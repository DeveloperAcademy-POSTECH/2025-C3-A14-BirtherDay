//
//  HomeView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

/// CouponTemplateView -> CouponInfoView -> CouponLetterView

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @StateObject private var couponViewModel = CreateCouponViewModel()
    
    var body: some View {
        NavigationStack(path: $navPathManager.appPaths) {
            ScrollView {
                VStack(spacing: 16) {
                    HomeHeaderView(text: "자~ 로고들어갑니다")
                    CreateCouponCTAView()
                    CouponShortcutView()
                    HomeDivider()
                    HomeHeaderView(text: "아직 미사용 된 쿠폰이 남아있어요")
                    UnusedCouponListView()
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
                            Text("CouponDetailView")
                            //                        CouponDetailView(viewModel: .init(coupon: .stub01)) // TODO: - remove stub
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
    
    // MARK: - Functions
    
    ///  쿠폰 만들러 가기
    func CreateCouponCTAView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.mainViolet100)
            
            VStack(alignment: .center, spacing: 20) {
                Text("나만의 특별한 쿠폰으로\n생일을 축하해볼까요?")
                    .lineSpacing(8)
                    .font(.b2)
                    .multilineTextAlignment(.center)
                
                // TODO: - Image 연결
                Rectangle()
                    .frame(width: 120, height: 120)
                
                Button(action: {
                    navPathManager.pushCreatePath(.selectTemplate)
                }) {
                    Text("쿠폰 만들러 가기")
                        .font(.sb1)
                }
                .buttonStyle(BDButtonStyle(buttonType: .activate))
                //.padding(.horizontal, 16)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .padding(.horizontal, 16)
    }
    
    /// 보관함가기 형제
    func CouponShortcutView() -> some View {
        VStack(spacing: 0) {
            HStack {
                Text("주고 받은 쿠폰을 확인해보세요!")
                    .font(.sb2)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 8)
            
            HStack(spacing: 0) {
                CouponShortcutCardView("선물 받은")
                CouponShortcutCardView("내가 보낸")
                    
            }
        }
    }
    
    /// 개별 보관함 가기
    func CouponShortcutCardView(_ tab: String) -> some View {
        Button(action: {
            navPathManager.pushCreatePath(.selectTemplate)
        }) {
            HStack(alignment: .center, spacing: 8) {
                if tab == "선물 받은" {
                    Rectangle()
                        .frame(width: 38, height: 38)
                    Text("선물 받은\n쿠폰")
                        .multilineTextAlignment(.leading)
                        .font(.sb1)
                        .foregroundStyle(Color.textTitle)
                } else {
                    Rectangle()
                        .frame(width: 38, height: 38)
                    Text("내가 보낸\n쿠폰")
                        .multilineTextAlignment(.leading)
                        .font(.sb1)
                        .foregroundStyle(Color.textTitle)
                }
            }
            .padding(.trailing, 8)
            .padding(20)
        }
        .background(Color.gray100)
        .cornerRadius(20)
        .padding(8)
        .padding(.top, 8)
        .padding(.bottom, -2)
    }
    
    /// 구분선
    func HomeDivider() -> some View {
        Divider().frame(height: 8).overlay(Color.gray100)
    }
    
    /// 헤더
    func HomeHeaderView(text: String) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text(text)
                    .font(.sb2)
                    .foregroundStyle(Color.textTitle)
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 8)
        }
    }
    
    /// 미사용 쿠폰 리스트
    func UnusedCouponListView() -> some View {
        // TODO: - Hstack 리스트 구현
        Rectangle()
            .foregroundStyle(Color.mainViolet100)
            .padding(.horizontal, 16)
            .frame(minHeight: 270)
    }
}


#Preview {
    HomeView()
        .environmentObject(BDNavigationPathManager())
}
