//
//  HomeView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI
import DotLottie
import KakaoSDKShare
import KakaoSDKCommon

struct HomeView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    @StateObject private var couponViewModel = CreateCouponViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var myCouponViewModel = MyCouponViewModel()
    @State private var animation = DotLottieAnimation(fileName: "giftbox", config: AnimationConfig(autoplay: true, loop: true, useFrameInterpolation: false)
    )
    
    @State private var couponType: CouponType = .received
    @State private var showSharedCouponModal: Bool = false
    
    var body: some View {
        NavigationStack(path: $navPathManager.appPaths) {
            ScrollView {
                VStack(spacing: 16) {
                    homeLogoView()
                    createCouponCTACardView()
                    homeHeaderView(text: "주고 받은 쿠폰을 확인해보세요!")
                    couponBoxSelectorView()
                    homeDivider()
                    //homeEmptyView()
                    unusedCouponListView()
                }
                .navigationDestination(for: BDAppPath.self) { path in
                    BDNavigationRoutingView(
                        destination: path,
                        createCouponViewModel: couponViewModel,
                        myCouponViewModel: myCouponViewModel
                    )
                }
            }
            .scrollIndicators(.hidden)
            .background(Color.bgLight)
        }
        .onAppear {
            Task {
                if SupabaseManager.shared.client.auth.currentSession == nil {
                    await homeViewModel.signUp()
                }
                
                await homeViewModel.fetchCoupons()
            }
        }
        .overlay {
            if showSharedCouponModal {
                CouponSharedModal(
                    homeViewModel: homeViewModel
                    , showSharedCouponModal: $showSharedCouponModal
                )
            }
        }
        .onOpenURL { url in
            if ShareApi.isKakaoTalkSharingUrl(url) {
                Task {
                    guard let userId = SupabaseManager.shared.client.auth.currentSession?.user.id.uuidString else {
                        fatalError("userId를 찾을 수 없습니다.")
                    }
                    
                    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                          let queryItems = components.queryItems else {
                        fatalError("쿼리 파라미터를 파싱할 수 없습니다.")
                    }
                    
                    guard let couponId = queryItems.first(where: { $0.name == "couponId" })?.value else {
                        fatalError("couponId를 찾을 수 없습니다.")
                    }
                    
                    withAnimation {
                        showSharedCouponModal = true;
                    }
                    
                    await homeViewModel.fetchCouponBy(couponId: couponId)
                    await homeViewModel.registerReceiverToCoupon(couponId: couponId, userId: userId)
                }
            }
        }
    }
    
    // MARK: - Views
    ///  쿠폰 만들러 가기
    func createCouponCTACardView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.mainViolet100)
            
            VStack(alignment: .center, spacing: 20) {
                Text("나만의 특별한 쿠폰으로\n생일을 축하해볼까요?")
                    .lineSpacing(8)
                    .font(.b2)
                    .multilineTextAlignment(.center)
                
                animation
                    .view()
                    .frame(minWidth: 150, minHeight: 150)
                    .padding(-16)
                
                Button {
                    navPathManager.pushCreatePath(.selectTemplate)
                } label: {
                    ZStack {
                        LinearGradient.createCouponBackground
                        HStack(spacing: 0) {
                            Text("쿠폰 만들러 가기 ")
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                        }
                        .font(.sb1)
                    }
                }
                .buttonStyle(BDButtonStyle(buttonType: .activate))
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
                
                Image(couponType.couponTypeImage)
                
                Text(type.couponBoxTitle)
                    .font(.sb1)
                    .foregroundStyle(Color.textTitle)
                    .lineSpacing(6)
                    .lineLimit(2)
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.trailing, 8)
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray100)
        .clipShape(
            RoundedRectangle(cornerRadius: 15)
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
    
    /// 홈 로고
    func homeLogoView() -> some View {
        HStack(spacing: 0) {
            Image("HomeLogo")
                .padding(.leading, 16)
                .padding(.top, 8)
            
            Spacer()
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
        VStack {
            // TODO: .mockCoupons -> coupons
            if homeViewModel.mockCoupons.isEmpty {
                homeEmptyView()
            } else {
                homeHeaderView(text: "아직 미사용 된 쿠폰이 남아있어요")
                ScrollView(.horizontal) {
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(homeViewModel.mockCoupons) { coupon in
                            Button {
                                navPathManager.pushMyCouponPath(.couponDetail(coupon))
                            } label: {
                                BDMiniCoupon(coupon: coupon)
                            }
                        }
                        Button {
                            navPathManager.pushMyCouponPath(.couponInventory(.received))
                        } label: {
                            BDAllMiniCoupon()
                        }
                    }
                    .padding(.horizontal, 16)
                }.scrollIndicators(.hidden)
            }
        }
    }
    
    func homeEmptyView() -> some View {
        ZStack {
            Image("homeEmptyCoupon")
                .resizable()
            Text("미사용된 쿠폰이 없어요!\n쿠폰을 더 생성하러 가볼까요?")
                .multilineTextAlignment(.center)
                .lineSpacing(8)
                .font(.sb1)
                .foregroundStyle(Color.textTitle)
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    HomeView()
        .environmentObject(BDNavigationPathManager())
}
