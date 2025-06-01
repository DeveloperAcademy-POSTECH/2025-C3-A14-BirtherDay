//
//  HomeView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @StateObject private var couponViewModel = CreateCouponViewModel()
    
    var body: some View {
        NavigationStack(path: $navPathManager.appPaths) {
            VStack {
                HomeFirstView(viewModel: couponViewModel)
                HomeSecondView()
            }
            .navigationDestination(for: BDAppPath.self) { path in
                switch path {
                case .create(let createPath):
                    switch createPath {
                    case .selectTemplate:
                        CouponTemplateView(viewModel: couponViewModel)
                    case .couponInfo:
                        CouponInfoView(viewModel: couponViewModel)
                    case .couponLetter:
                        CouponLetterView(viewModel: couponViewModel)
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
                }
            }
        }
    }
}

///  쿠폰 만들러 가기 뷰에 해당
struct HomeFirstView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    let viewModel: CreateCouponViewModel
    
    var body: some View {
        Button(action: {
            // 새로운 쿠폰 생성 시작할 때 데이터 초기화
            viewModel.resetCouponCreation()
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
