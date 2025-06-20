//
//  CouponInteractionView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI
struct CouponInteractionView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    var viewModel: CouponDetailViewModel
    
    var minimuDetectedDistance: Float = 2.0     // 2m부터 배경 애니메이션
    var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    @State private var animatedHeight: CGFloat = 0.0
    @State private var animatedDistance: Float = 0.0

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.bgDark.ignoresSafeArea()
                Color.mainPrimary
                    .ignoresSafeArea()
                    .frame(height: animatedHeight)
                    
            }

            VStack(spacing: 30) {
                VStack {
                    Text("서로의 휴대폰을\n조금 더 가까이 이동시켜주세요!")
                        .font(.sb5)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.bgLight)
                    
                    BDTemplate(data: viewModel.selectedCoupon, isShowSubtitleView: true, horizontalPadding: 44)
                        .scaleEffect(204/320)
                        .rotationEffect(.degrees(7.86))

                    Text("0.5m 이내로 가까워졌을 때 사용이 가능해요.")
                        .font(.m1)
                        .foregroundStyle(Color.gray100)
                }

                distanceView()
            }
        }
        .onAppear {
            print("viewModel.startNI()")
            viewModel.startNI()
            print("screenHeight: \(screenHeight)")
        }
        .onChange(of: viewModel.distance) { oldValue, newValue in
            guard let newValue else { return }
            
            // TODO: - 로직 함수 수정하기
            withAnimation(.easeInOut(duration: 1.0)) {
                let clampedValue = max(newValue, 0)
                animatedDistance = clampedValue
                ///
                /// 2m : 0
                /// 0.2m : height
                let height = screenHeight - CGFloat((clampedValue - 0.2) / (minimuDetectedDistance)) * screenHeight
                animatedHeight = max(0, height)
            }
        }
        .onChange(of: viewModel.distance) { oldValue, newValue in
            if let newValue = newValue {
                if viewModel.isNearby(newValue) {
                    navPathManager.pushMyCouponPath(.interactionComplete)
                    
                    viewModel.stopNI()
                    viewModel.stopMPC()
                    
                    Task {
                        print("await viewModel.useCoupon()")
                        let result = await viewModel.useCoupon()
                        print("result: \(result)")
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden()
    }

    func distanceView() -> some View {
        HStack {
            Text("우리사이 거리")
                .foregroundStyle(Color.bgLight)

            Text("\(viewModel.distance ?? 0.0, specifier: "%.2f")m")
                .foregroundStyle(animatedHeight == screenHeight ? Color.mainPrimary : Color.bgLight)
        }
        .font(.sb5)
    }
}
