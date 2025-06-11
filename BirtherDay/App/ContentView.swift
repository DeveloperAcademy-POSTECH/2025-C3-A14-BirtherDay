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
    
    private var authService: AuthService = AuthService()

    var body: some View {
        ZStack {
            if !isOnboarded {
                OnboardingView()
                    .transition(.asymmetric(
                        insertion: .opacity,
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            } else {
                TestView()
//                HomeView()
//                    .environmentObject(bdNavigationManager)
//                    .transition(.asymmetric(
//                        insertion: .move(edge: .trailing).combined(with: .opacity),
//                        removal: .opacity
//                    ))
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isOnboarded)
        .onAppear { checkSignIn() }
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
