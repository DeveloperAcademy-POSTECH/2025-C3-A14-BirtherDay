//
//  CounponReceiveModal.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 6/9/25.
//

import SwiftUI

struct CouponSharedModal: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var homeViewModel: HomeViewModel
    @Binding var showSharedCouponModal: Bool
    
    var body: some View {
        ZStack {
            // Background
            Color.black.opacity(0.3)
                .ignoresSafeArea(.all)
                .onTapGesture {_ in
                    withAnimation {
                        showSharedCouponModal = false
                    }
                }
            
            NotificationCard()
        }
    }
    
    func NotificationCard() -> some View {
        VStack {
            VStack {
                Text("생일 쿠폰이 도착했어요!")
                    .font(.b3)
                    .padding(.bottom, 4)
                
                Text("쿠폰을 확인하고,\n 함께 즐거운 시간을 보내 보세요!")
                    .font(.caption)
                    .foregroundStyle(Color.textCaption1)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                
                Image("CoupontWithConpetti")
                    .padding(.bottom, 18)
                
                Button {
                    guard let coupon = homeViewModel.coupon else {
                        print("coupon is nil")
                        return
                    }
                    
                    showSharedCouponModal = false
                    navPathManager.pushMyCouponPath(.couponDetail(coupon, CouponType.received))
                } label: {
                    Text("확인하러 가기 >")
                        .font(.sb1)
                        .foregroundStyle(Color.white)
                }
                .buttonStyle(BDButtonStyle(buttonType: .activate))
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 25)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white)
            )
        }
        .padding(.horizontal, 16)
        .transition(.scale)
    }
}
