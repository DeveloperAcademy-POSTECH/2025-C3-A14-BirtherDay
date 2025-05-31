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

// 쿠폰 생성 과정의 모든 데이터를 관리하는 통합 구조체
struct CouponCreationData {
    // 1단계: 템플릿 선택
    var template: CouponTemplate?
    
    // 2단계: 쿠폰 정보 입력
    var couponTitle: String?
    var senderName: String?
    var expireDate: Date?
    
    // 3단계: 편지 작성
    var letterContent: String?
    
    // 4단계: 사진 선택
    var selectedPhoto: UIImage?
    
    init() {
        // 기본값들 설정
        self.expireDate = Date()
    }
}

class BDNavigationPathManager: ObservableObject {
    /// Path Stack
    @Published var appPaths: [BDAppPath] = []
    
    // 쿠폰 생성 과정의 모든 데이터를 하나로 관리
    @Published var couponCreationData = CouponCreationData()
    
    // 쿠폰 생성 데이터 초기화 (새로운 쿠폰 생성 시작 시 호출)
    func resetCouponCreation() {
        couponCreationData = CouponCreationData()
    }
    
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

