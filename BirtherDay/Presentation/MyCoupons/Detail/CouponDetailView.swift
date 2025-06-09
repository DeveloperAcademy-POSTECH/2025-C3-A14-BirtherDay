//
//  CouponDeatilView.swift
//  BirtherDay
//
//  Created by Rama on 6/5/25.
//

import SwiftUI

struct CouponDetailView: View {
    
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    var viewModel: CouponDetailViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                DetailedCoupon(couponData: viewModel.selectedCoupon)
            }
            .background(viewModel.selectedCoupon.template.backgroundColor.ignoresSafeArea())
            .scrollIndicators(.hidden)
            
            buttonsView()
                
                
        }
        .onAppear {
            print("viewModel.startupMPC()")
            viewModel.startupMPC()
        }
    }
    
    func buttonsView()-> some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    
                } label: {
                    Text("공유")
                }
                .buttonStyle(BDButtonStyle(buttonType: .activate))
                
                Button {
                    navPathManager.pushMyCouponPath(.interaction(viewModel: viewModel ))
                } label: {
                    Text("사용하기")
                }
                .buttonStyle(BDButtonStyle(buttonType: viewModel.isConnectWithPeer ? .activate : .deactivate))
                .disabled(!viewModel.isConnectWithPeer)
    
            }
            .padding(.top, 37)
            .padding(.horizontal, 16)
            .background(viewModel.selectedCoupon.template.buttonBackgroundColor.ignoresSafeArea())
        }
    }
}

#Preview {
    CouponDetailView(viewModel: CouponDetailViewModel(selectedCoupon: .stub01))
        .environmentObject(BDNavigationPathManager())
}
