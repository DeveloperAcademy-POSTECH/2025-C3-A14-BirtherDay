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
    
    @State private var showShareModal = false
    @State private var isLoading: Bool = false
    
    //TODO: 삭제
    
    private let shareModalHeight: CGFloat = 195
    
    var body: some View {
        ZStack {
            ScrollView {
                completedCouponView()
                    .padding(.top, 16)
            }
            
            bottomGradientView()
            
            if isLoading {
                ProgressView()
                    .padding(.bottom, 20)
            } else {
                bottomActionView()
                    .padding(.horizontal, 15)
            }
        }
        .background(viewModel.couponData.template.backgroundColor)
        .keyboardAware()
        .bdNavigationBar(
            title: "쿠폰 생성 완료",
            backButtonAction: navPathManager.popPath,
            color: UIColor(
                viewModel.couponData.template.backgroundColor
            )
        )
        .sheet(isPresented: $showShareModal) {
            shareModalView()
                .presentationDetents([.height(shareModalHeight)])
        }
    }
    
    func completedCouponView() -> some View {
        Group {
            if let couponForResponse = viewModel.couponForResponse {
                DetailedCoupon(couponData: couponForResponse)
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
    
    func bottomGradientView() -> some View {
        VStack {
            Spacer()
            
            (viewModel.couponData.template == .orange ? LinearGradient.orangeButtonBackground : LinearGradient.blueButtonBackground)
                .frame(maxWidth: .infinity)
                .frame(height: 143)
        }
        .ignoresSafeArea(.all)
    }
    
    func shareButtonView() -> some View {
        Button {
            showShareModal.toggle()
        } label: {
            Label("공유", systemImage: "square.and.arrow.up")
        }
        .buttonStyle(BDButtonStyle(buttonType: .share))
    }
    
    func shareModalView() -> some View {
        VStack {
            Capsule()
                .fill(Color.gray)
                .frame(
                    width: 40,
                    height: 5
                )
                .padding(.top, 2)
            
            Text("공유하기")
                .font(.b2)
                .padding(.top, 16)
            
            ShareButtons()
                .padding(.top, 24)
        }
    }
    
    func navigateHomeButtonView() -> some View {
        Button {
            Task {
                isLoading = true
                await viewModel.uploadCoupon()
                isLoading = false
                viewModel.resetCouponData()
                navPathManager.goToRoot()
            }
        } label: {
            Text("홈으로")
        }
        .buttonStyle(BDButtonStyle(buttonType: .activate))
    }
}

#Preview {
    CouponCompleteView(viewModel: CreateCouponViewModel())
}
