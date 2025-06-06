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
    @State private var couponType: CouponType = .received
    private var homeViewModel = HomeViewModel()
    private var myCouponViewModel = MyCouponViewModel()
    
    var body: some View {
        NavigationStack(path: $navPathManager.appPaths) {
            ScrollView {
                VStack(spacing: 16) {
                    homeHeaderView(text: "자~ 로고들어갑니다 ^^")
                    createCouponCTACardView()
                    homeHeaderView(text: "주고 받은 쿠폰을 확인해보세요!")
                    couponBoxSelectorView()
                    homeDivider()
                    homeHeaderView(text: "아직 미사용 된 쿠폰이 남아있어요")
                    unusedCouponListView()
                }
                .navigationDestination(for: BDAppPath.self) { path in
                    BDNavigationRoutingView(
                        destination: path,
                        createCouponViewModel: couponViewModel,
//                        couponDetailViewModel: CouponDetailViewModel(),
                        myCouponViewModel: myCouponViewModel
                    )
                }
            }.scrollIndicators(.hidden)
        }
    }
    
    // MARK: - Views
    ///  쿠폰 만들러 가기
    func createCouponCTACardView() -> some View {
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
    
    /// 보관함 가기 형제
    func couponBoxSelectorView() -> some View {
        HStack(spacing: 16) {
            couponBoxCardView(.received)
            couponBoxCardView(.sent)
        }
        .padding(.horizontal, 16)
    }
    
    /// 개별 보관함 가기
    func couponBoxCardView(_ type: CouponType) -> some View {
        
        Button {
            couponType = type
            navPathManager.pushMyCouponPath(.couponInventory(couponType))
        } label: {
            HStack(alignment: .center, spacing: 8) {
        
                Rectangle()
                    .frame(width: 38, height: 38)
                
                Text(type.couponBoxTitle)
                    .font(.sb1)
                    .foregroundStyle(Color.textTitle)
                    .lineSpacing(6)
                    .lineLimit(2)
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                //Spacer()
            }
            .padding(.trailing, 8)
            .padding(20)
        }
        .background(Color.gray100)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .padding(.bottom, 6)
    }
    
    /// 구분선
    func homeDivider() -> some View {
        Divider().frame(height: 8).overlay(Color.gray100)
    }
    
    /// 헤더
    func homeHeaderView(text: String) -> some View {
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

    // TODO: - 미사용 쿠폰 리스트
    /// 1. fetching
    ///     1.1. 에러핸들링
    /// 2. isEmpty 여부 검사
    ///     2.1. 텅!
    ///     2.2.  HStack으로 카드리스트뷰
    /// 3. 5개 카드 이후, 더보기 카드
    func unusedCouponListView() -> some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 8) {
                
                // TODO: - 일정 갯수 이상 나오면, 더보기 카드(보관함)
                ForEach(homeViewModel.mockCoupons) { coupon in
                    Button {
                        navPathManager.pushMyCouponPath(.couponDetail(coupon))
                    } label: {
                        BDMiniCoupon(coupon: coupon)
                    }
                    
                }
            }
            .padding(.horizontal, 16)
        }.scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
        .environmentObject(BDNavigationPathManager())
}
