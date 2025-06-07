//
//  CouponInteractionView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI
struct CouponInteractionView: View {
    @Bindable var viewModel: CouponDetailViewModel
    
    var minimuDetectedDistance: Float = 2.0
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
                    
                    

                    Text("0.5m 이내로 가까워졌을 때 사용이 가능해요.")
                        .font(.m1)
                        .foregroundStyle(Color.gray100)
                }

                distanceView()
            }
        }
        .onAppear {
            viewModel.startNI()
        }
        .animation(.linear(duration: 0.3), value: viewModel.distance)
        .onChange(of: viewModel.distance ?? 0.0) { _, new in
            let new = max(new, 0)
            animatedDistance = new
            let height = screenHeight - CGFloat(new / minimuDetectedDistance) * screenHeight
            animatedHeight = max(0, height)
        }
    }

    func distanceView() -> some View {
        HStack {
            Text("우리사이 거리")
                .foregroundStyle(Color.bgLight)

            Text("\(animatedDistance, specifier: "%.2f")m")
                .foregroundStyle(animatedHeight == screenHeight ? Color.mainPrimary : Color.bgLight)
        }
        .font(.sb5)
    }
}
#Preview {
    CouponInteractionView(viewModel: CouponDetailViewModel(selectedCoupon: .stub01))
}
