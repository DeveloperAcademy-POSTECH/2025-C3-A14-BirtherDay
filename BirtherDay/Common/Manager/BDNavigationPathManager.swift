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
    
    /// Ceate Path에서 뷰 전환
    func addCreatePath(_ path: BDCreateCouponPath) {
        appPaths.append(.create(path))
    }
    
    /// MyCoupon Path에서 뷰 전환
    func addMyCouponPath(_ path: BDMyCouponPath) {
        appPaths.append(.myCoupon(path))
    }
    
    /// 홈뷰로 가기
    func removeAllPath() {
        appPaths.removeAll()
    }
    
    /// 뒤로 가기
    func popPath() {
        appPaths.popLast()
    }
}

