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
            viewModel.coupon?.template.backgroundColor
            ScrollView(.vertical) {
                VStack {
                    DetailedCoupon(couponData: viewModel.coupon ?? .stub01)
                }
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            viewModel.loadCouponDetail()
        }
    }
}

#Preview {
    CouponDetailView(viewModel: CouponDetailViewModel())
}
