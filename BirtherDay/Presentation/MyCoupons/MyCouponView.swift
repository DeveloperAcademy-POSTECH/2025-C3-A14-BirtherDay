//
//  ReceivedCouponView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

struct MyCouponView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @State private var selectedTab: CouponUsageTab = .unused
    @ObservedObject var myCouponViewModel: MyCouponViewModel
    
    var couponType: CouponType
    
    var body: some View {
        VStack(spacing: 0) {
            MyCouponBannerView()
            couponSegmentedView()
                .padding(.top, 32)
            //Spacer()
            
            couponInventoryView()
                .padding(.top, 24)
            
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        
//        .navigationTitle(couponType.couponNavigationTitle)
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
        
//        .toolbar {
//            leadingBackButton
//        }
        
        .bdNavigationBar(
            title: "\(couponType.couponNavigationTitle)",
            backButtonAction: navPathManager.popPath,
            color: UIColor(
                Color.bgLight
            )
        )
        /// 최초 fetch.
        .onAppear {
            if myCouponViewModel.coupons.isEmpty {
                Task {
                    await myCouponViewModel.fetchCoupons(for: couponType, isUsed: selectedTab.isUsed)
                }
            }
        }
        
        /// tab 변화 시, 캐시에서 필터링함.
        .onChange(of: selectedTab) {
            myCouponViewModel.filterCoupons(by: selectedTab.isUsed)
        }
    }
    // MARK: - Views
    /// 상단 배너
    func MyCouponBannerView() -> some View {
        HStack(spacing: 0) {
            Text(couponType.bannerText)
                .font(.sb5)
                .foregroundStyle(Color.textTitle)
                .lineSpacing(6)
                .frame(alignment: .leading)
            
            Spacer()
            
            Image(couponType.myCouponTypeImage)
        }
    }
    
    /// 사용/미사용 쿠폰 탭 세그먼트 전체 뷰
    func couponSegmentedView() -> some View {
        HStack(spacing: 20) {
            ForEach(CouponUsageTab.allCases, id: \.self) { tab in
                segmentedTabButton(tab: tab)
            }
            Spacer()
        }
    }
    
    /// 탭 하나를 나타내는 버튼 (사용 / 미사용)
    func segmentedTabButton(tab: CouponUsageTab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Text(tab.segmentTitle)
                    .foregroundStyle(selectedTab == tab ? Color.textTitle : .gray300)
                    .font(.sb1)
                if selectedTab == tab {
                    Capsule()
                        .fill(Color.textTitle)
                        .frame(width: 44, height: 2)
                }
            }
            //.padding(.bottom, -8)
        }
        .buttonStyle(.plain)
    }
    
    // TODO: - 쿠폰 인벤토리 뷰
    func couponInventoryView() -> some View {
        VStack {
            if myCouponViewModel.coupons.isEmpty {
                VStack {
                    Spacer()
                    Text(selectedTab == .used ? couponType.emptyUsedText : couponType.emptyUnusedText)
                    Spacer()
                }
                .multilineTextAlignment(.center)
                .lineSpacing(8)
                .frame(maxWidth: .infinity)
                .font(.sb3)
                .foregroundStyle(Color.textCaption1)
                
                Spacer()
                
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(myCouponViewModel.coupons) { coupon in
                            Button {
                                navPathManager.pushMyCouponPath(.couponDetail(coupon))
                            } label: {
                                BDMiniCoupon(coupon: coupon)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }.scrollIndicators(.hidden)
            }
        }
    }
}

/// 네비게이션 타이틀, popBtn
private extension MyCouponView {
    var leadingBackButton: ToolbarItem<Void, some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: navPathManager.popPath) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    MyCouponView(myCouponViewModel: MyCouponViewModel(), couponType: .sent)
        .environmentObject(BDNavigationPathManager())
}
