//
//  HomeView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    var body: some View {
        NavigationStack(path: $navPathManager.appPaths) {
            VStack {
                HomeFirstView()
                HomeSecondView()
                HomeThirdView()
            }
            .navigationDestination(for: BDAppPath.self) { path in
                switch path {
                case .create(let createPath):
                    switch createPath {
                    case .selectTemplate:
                        CouponTemplateView()
                    case .couponInfo:
                        CouponInfoView()
                    case .couponLetter:
                        CouponLetterView()
                    case .couponPicture:
                        CouponPhotoView()
                    case .couponComplete:
                        CouponCompleteView()
                    }
                case .myCoupon(let myPath):
                    switch myPath {
                    case .couponInventory:
                        MyCouponView()
                    case .couponDetail:
                        CouponDetailView(viewModel: .init(coupon: .stub01)) // TODO: - remove stub
                    case .interaction:
                        CouponInteractionView()
                    case .interactionComplete:
                        InteractionCompleteView()
                    }
                case .test(let testPath):
                    switch testPath {
                    case .test:
                        TestView()
                    }
                }
            }
        }
    }
}

///  쿠폰 만들러 가기 뷰에 해당
struct HomeFirstView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    var body: some View {
        Button(action: {
            navPathManager.pushCreatePath(.selectTemplate)
        }) {
            Text("Move To CreateCoupon")
        }
        
    }
}

///  선물 받은 쿠폰, 내가 보낸 쿠폰에 해당
struct HomeSecondView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    var body: some View {
        Button(action: {
            navPathManager.pushMyCouponPath(.couponInventory)
        }) {
            Text("Move To MyCoupon")
        }
    }
}

///  테스트 뷰
struct HomeThirdView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    var body: some View {
        Button(action: {
            navPathManager.pushTestPath(.test)
        }) {
            Text("Move To TestView")
        }
    }
}
