//
//  CompletedCouponView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import SwiftUI
import Kingfisher

struct CouponCompleteView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var viewModel: CreateCouponViewModel
    
    var completedCouponData: RetrieveCouponResponse? {
        viewModel.buildCoupon()
    }
    
    var body: some View {
        VStack {
            if let completedCouponData = completedCouponData {
                DetailedCoupon(couponData: completedCouponData)
                    .padding(.top, 16)
            } else {
                Text("쿠폰 정보가 불완전합니다.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .keyboardAware(
            navigationTitle: "쿠폰 생성 완료",
            onBackButtonTapped: {
                navPathManager.popPath()
            }
        )
    }
}

#Preview {
    CouponCompleteView(viewModel: CreateCouponViewModel())
}
 
