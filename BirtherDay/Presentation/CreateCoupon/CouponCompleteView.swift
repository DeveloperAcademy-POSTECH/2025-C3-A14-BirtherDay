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
        .keyboardAware(
            navigationTitle: "사진 첨부",
            onBackButtonTapped: {
                navPathManager.popPath()
            }
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
            
            HStack(spacing: 25) {
                kakaoShareButtonView()
                moreShareButtonView()
            }
            .padding(.top, 24)
        }
    }
    
    func navigateHomeButtonView() -> some View {
        Button {
            Task {
                isLoading = true
                await viewModel.uploadCoupon()
                isLoading = false
                navPathManager.goToRoot()
            }
        } label: {
            Text("홈으로")
        }
        .buttonStyle(BDButtonStyle(buttonType: .activate))
    }
    
    func kakaoShareButtonView() -> some View {
        VStack {
            Button {
                
            } label: {
                Image("kakaoIcon")
                    .resizable()
                    .frame(
                        width: 57,
                        height: 57
                    )
            }
            
            Text("카카오톡")
                .font(.r1)
        }
    }
    
    func moreShareButtonView() -> some View {
        VStack {
            Button {
                
            } label: {
                Image("moreIcon")
                    .resizable()
                    .frame(
                        width: 57,
                        height: 57
                    )
            }
            
            Text("더보기")
                .font(.r1)
        }
    }
}

#Preview {
    CouponCompleteView(viewModel: CreateCouponViewModel())
}
