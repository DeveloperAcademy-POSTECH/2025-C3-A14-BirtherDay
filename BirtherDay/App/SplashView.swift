//
//  SplashView.swift
//  BirtherDay
//
//  Created by rundo on 6/12/25.
//

import SwiftUI
import DotLottie

struct SplashView: View {
    
    @State private var animation = DotLottieAnimation(
        fileName: "splash",
        config: AnimationConfig(
            autoplay: true,
            loop: true,
            useFrameInterpolation: true
        )
    )
    
    var body: some View {
        ZStack {
            Color.mainPrimary.ignoresSafeArea()
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    animation
                        .view()
                }
                .frame(width: 176, height: 176)
                
                // TODO: 나중에 Coup:off 문구가 들어간 lottie 파일로 교체해야 함
//                Image("splashText")
            }
        }
    }
}

#Preview {
    SplashView()
}
