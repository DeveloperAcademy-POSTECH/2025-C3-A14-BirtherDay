//
//  CouponDeatilView.swift
//  BirtherDay
//
//  Created by Rama on 6/5/25.
//

import SwiftUI

struct CouponDetailView: View {
    
    var viewModel: CouponDetailViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                DetailedCoupon(couponData:viewModel.coupon ?? .stub01)
                
            }
            .background(viewModel.coupon?.template.backgroundColor.ignoresSafeArea())
            .scrollIndicators(.hidden)
            
            buttonsView()
                
                
        }
        .onAppear {
            viewModel.loadCouponDetail()
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
                    
                } label: {
                    Text("사용하기")
                }
                .buttonStyle(BDButtonStyle(buttonType: .activate))
            }
            .padding(.top, 37)
            .padding(.horizontal, 16)
            .background(viewModel.coupon?.template.buttonBackgroundColor.ignoresSafeArea())
        }
    }
}

#Preview {
    CouponDetailView(viewModel: CouponDetailViewModel())
}
