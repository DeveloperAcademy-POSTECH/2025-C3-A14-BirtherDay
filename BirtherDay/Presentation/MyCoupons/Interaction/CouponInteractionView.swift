//
//  CouponInteractionView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponInteractionView: View {
    var viewModel: CouponDetailViewModel
    
    @State var distance: Float = 0.8   // TODO: - distance 0.00m 연결
    var minimuDetectedDistance: Float = 2.0
    var screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.bgDark.ignoresSafeArea()
                Color.mainPrimary.ignoresSafeArea()
                    .frame(height: calDistanceToScreenHeight()) // distance에 따른 높이 조절
            }
            VStack(spacing: 30) {   // TODO: - 쿠폰 영역에 따른 dashed line 크기 수정하기
                VStack {
                    Text("서로의 휴대폰을\n조금 더 가까이 이동시켜주세요!")
                        .font(.sb5)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.bgLight)
                    
                    Text("0.5m 이내로 가까워졌을 때 사용이 가능해요.")
                        .font(.m1)
                        .foregroundStyle(Color.gray100)
                }
//                BDTemplate(data: <#Coupon#>)
//                    .scaleEffect(204/320)
//                    .rotationEffect(.degrees(7.86))
                    
                distanceView()
            }
                
        }
        .onAppear {
//            viewModel.startNI()
        }
    }
    
    func distanceView()-> some View {
        HStack {
            Text("우리사이 거리")
                .foregroundStyle(Color.bgLight)
                
            
            Text("\(distance, specifier: "%.2f")m")
                .foregroundStyle(distance == 2.0 ? Color.mainPrimary : Color.bgLight)
        }
        .font(.sb5)
    }
    
    
    // methods
    /// 측정된 distance를 기반으로 배경색의 높이를 구하는 함수
    func calDistanceToScreenHeight() -> CGFloat {
        
        if let distance = viewModel.distance {
            return screenHeight - CGFloat(distance / minimuDetectedDistance) * screenHeight
        } else {
            return 100.0
        }
    }
}

#Preview {
    CouponInteractionView(viewModel: CouponDetailViewModel(selectedCoupon: .stub01))
}
