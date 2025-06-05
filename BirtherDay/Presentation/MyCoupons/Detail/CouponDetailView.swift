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
}

#Preview {
    CouponDetailView(viewModel: CouponDetailViewModel())
}
