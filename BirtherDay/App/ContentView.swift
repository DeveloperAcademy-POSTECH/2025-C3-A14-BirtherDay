//
//  ContentView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarded") private var isOnboarded: Bool = false
    @StateObject private var bdNavigationManager = BDNavigationPathManager()
    @State private var showSplash: Bool = true  // 앱 시작 시 true로 초기화
    
    private var authService: AuthService = AuthService()

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else if !isOnboarded {
                OnboardingView()
                    .transition(.asymmetric(
                        insertion: .opacity,
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            } else {
                HomeView()
                    .environmentObject(bdNavigationManager)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isOnboarded)
        .animation(.easeInOut(duration: 0.3), value: showSplash)
        .onAppear {
            checkSignIn()
            showSplashScreen()  // 앱 시작 시 항상 스플래시 표시
        }
        .onChange(of: isOnboarded) { oldValue, newValue in
            if newValue == true && oldValue == false {
                // 온보딩 완료 시에는 바로 홈으로 (스플래시 없이)
                // 이미 스플래시는 앱 시작 시 보여줬으므로
            }
        }
    }
    
    private func showSplashScreen() {
        // 1.5초 후 스플래시 화면 숨김
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                showSplash = false
            }
        }
    }
}

extension ContentView {
    func checkSignIn() {
        if let session = SupabaseManager.shared.client.auth.currentSession {
            print("가입된 사용자: \(session.user.id)")
        } else {
            Task {
                do {
                    let session = try await authService.signUp()
                    print("신규 가입: \(session.user.id)")
                } catch {
                    print("\(error)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
