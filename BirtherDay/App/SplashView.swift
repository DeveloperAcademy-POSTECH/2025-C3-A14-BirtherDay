//
//  SplashView.swift
//  BirtherDay
//
//  Created by rundo on 6/12/25.
//

import SwiftUI

struct SplashView: View {
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            Color.mainPrimary.ignoresSafeArea()
            .ignoresSafeArea()
            
            // 스플래시 로고
            Image("splash")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}

#Preview {
    SplashView()
}
