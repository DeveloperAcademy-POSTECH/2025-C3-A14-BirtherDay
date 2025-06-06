//
//  CompletedCouponView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import UIKit
import SwiftUI
import Kingfisher

struct CouponCompleteView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var viewModel: CreateCouponViewModel
    
    var completedCouponData: RetrieveCouponResponse? {
        viewModel.buildCoupon()
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                completedCouponView()
                    .padding(.top, 16)
            }
            
            bottomActionView()
                .padding(.horizontal, 15)
                .padding(.bottom, 20)
        }
        .keyboardAware(
            navigationTitle: "사진 첨부",
            onBackButtonTapped: {
                navPathManager.popPath()
            }
        )
    }
    
    func completedCouponView() -> some View {
        Group {
            if let completedCouponData = completedCouponData {
                DetailedCoupon(couponData: completedCouponData)
            } else {
                Text("쿠폰 정보 없음")
            }
        }
    }
    
    func bottomActionView() -> some View {
        VStack {
            Spacer()
            
            HStack(spacing: 15) {
                shareButtonView()
                navigateHomeButtonView()
            }
        }
    }
    
    func shareButtonView() -> some View {
        Button {} label: {
            Label("공유", systemImage: "square.and.arrow.up")
        }
        .buttonStyle(BDButtonStyle(buttonType: .share))
    }
    
    func navigateHomeButtonView() -> some View {
        Button {} label: {
            Text("홈으로")
        }
        .buttonStyle(BDButtonStyle(buttonType: .activate))
    }
}

#Preview {
    CouponCompleteView(viewModel: CreateCouponViewModel())
}
