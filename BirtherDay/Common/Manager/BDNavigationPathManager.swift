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
    case test(BDTestPath)
}

enum BDCreateCouponPath: Hashable, Equatable {
    case selectTemplate
    case couponInfo
    case couponLetter
    case couponPicture
    case couponComplete
}

enum BDMyCouponPath: Hashable, Equatable {
    case couponInventory(CouponType)
    
    /// couponDetailView로 넘어갈 때, couponId 넘겨주기 -> 넘긴 couponId로 쿠폰 상세내역 조회
    case couponDetail(String)
    case interaction
    case interactionComplete
}

enum BDTestPath: Hashable, Equatable {
    case test
}

class BDNavigationPathManager: ObservableObject {
    /// Path Stack
    @Published var appPaths: [BDAppPath] = []
    
    /// Ceate Path에서 뷰 전환
    func pushCreatePath(_ path: BDCreateCouponPath) {
        appPaths.append(.create(path))
    }
    
    /// MyCoupon Path에서 뷰 전환
    func pushMyCouponPath(_ path: BDMyCouponPath) {
        appPaths.append(.myCoupon(path))
    }
    
    func pushTestPath(_ path: BDTestPath) {
        appPaths.append(.test(path))
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

