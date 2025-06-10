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
    
    @Environment(\.scenePhase) private var scenePhase
    
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
        .navigationBarBackButtonHidden()
        .bdNavigationBar(title: "쿠폰 상세보기") {
            viewModel.stopMPC()
            navPathManager.popPath()
        }
        .onDisappear {
            print("ondisappear called")
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            switch scenePhase {
            case .active:
                viewModel.startupMPC()
            case .background, .inactive:
                viewModel.stopMPC()
            @unknown default:
                break
            }
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
                    
                    if viewModel.isConnectWithPeer {
                        navPathManager.pushMyCouponPath(.interaction(viewModel: viewModel))
                    } else {
                        
                    }
                    
                    
                } label: {
                    Text("사용하기")
                }
                .buttonStyle(BDButtonStyle(buttonType: viewModel.isConnectWithPeer ? .activate : .deactivate))
    
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
