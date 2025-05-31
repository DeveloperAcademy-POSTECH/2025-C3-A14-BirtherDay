//
//  BDNavigationPathManager.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import SwiftUI

/// 홈뷰로부터 가능 Path 종류
enum BDAppPath: Hashable {
    case create(BDCreateCouponPath)
    case myCoupon(BDMyCouponPath)
}

enum BDCreateCouponPath: Hashable, Equatable {
    case selectTemplate
    case couponInfo
    case couponLetter
    case couponPicture
    case couponComplete
}

enum BDMyCouponPath: Hashable, Equatable {
    case couponInventory
    case couponDetail
    case interaction
    case interactionComplete
}

class BDNavigationPathManager: ObservableObject {
    /// Path Stack
    @Published var appPaths: [BDAppPath] = []
    
    // 선택된 쿠폰 템플릿을 저장
    @Published var selectedCouponTemplate: CouponTemplate?
    
    // 쿠폰 생성 과정에서 수집된 데이터를 저장
    @Published var couponData: CouponData?
    
    /// Ceate Path에서 뷰 전환
    func pushCreatePath(_ path: BDCreateCouponPath) {
        appPaths.append(.create(path))
    }
    
    /// MyCoupon Path에서 뷰 전환
    func pushMyCouponPath(_ path: BDMyCouponPath) {
        appPaths.append(.myCoupon(path))
    }
    
    /// 홈뷰로 가기
    func goToRoot() {
        appPaths.removeAll()
    }
    
    /// 뒤로 가기
    func popPath() {
        appPaths.popLast()
    }
}

