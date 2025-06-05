//
//  BDNavigationRoutingView.swift
//  BirtherDay
//
//  Created by Soop on 6/5/25.
//

import SwiftUI

struct BDNavigationRoutingView: View {
    @State var destination: BDAppPath
    
    // 뷰모델 주입
    @ObservedObject var createCouponViewModel: CreateCouponViewModel
    var couponDetailViewModel: CouponDetailViewModel
    
    var body: some View {
        switch destination {
        case .create(let bdCreateCouponPath):
            switch bdCreateCouponPath {
            case .selectTemplate:
                CouponTemplateView(viewModel: createCouponViewModel)
                
            case .couponInfo:
                CouponInfoView(viewModel: createCouponViewModel)
                
            case .couponLetter:
                CouponLetterView(viewModel: createCouponViewModel)
                
            case .couponPicture:
                CouponPhotoView(viewModel: createCouponViewModel)
                
            case .couponComplete:
                CouponCompleteView(viewModel: createCouponViewModel)
            }
        case .myCoupon(let bdMyCouponPath):
            switch bdMyCouponPath {
            case .couponInventory(let type):
                MyCouponView(couponType: type)
                
            case .couponDetail:
                CouponDetailView()
                
            case .interaction:
                CouponInteractionView(viewModel: couponDetailViewModel)
                
            case .interactionComplete:
                InteractionCompleteView()
            }
        case .test(let bdTestPath):
            switch bdTestPath {
            case .test:
                TestView()
            }
        }
    }
}
