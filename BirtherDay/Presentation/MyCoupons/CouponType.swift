//
//  CouponType.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/4/25.
//

import Foundation

/// 쿠폰 타입
enum CouponType: String, Equatable {
    case sent
    case received
    
    /// 네비게이션 타이틀
    var couponNavigationTitle: String {
        switch self {
        case .sent:
            return "내가 보낸 쿠폰"
            
        case .received:
            return "선물 받은 쿠폰"
        }
    }
    
    /// 배너 텍스트
    var bannerText: String {
        switch self {
        case .sent:
            return "함께 내가 보낸 쿠폰들을\n사용해보아요!"
            
        case .received:
            return "함께 내가 받은 쿠폰들을\n사용해보아요!"
        }
    }
    
    /// 배너 우측 아이콘
    var bannerImage: String {
        switch self {
        case .sent:
            return "sentImage"
            
        case .received:
            return "receivedImage"
        }
    }
    
    /// 홈 -> 쿠폰박스 타이틀
    var couponBoxTitle: String {
        switch self {
        case .sent:
            return "내가 보낸\n쿠폰"
            
        case .received:
            return "선물 받은\n쿠폰"
        }
    }
    
    /// 미사용 쿠폰이 없을 때, 표시할 텍스트
    var emptyUnusedText: String {
        switch self {
        case .sent:
            return "아직 보낸 쿠폰이\n없어요!"
            
        case .received:
            return "아직 받은 쿠폰이\n없어요!"
        }
    }
    
    /// 사용완료 쿠폰이 없을 때, 표시할 텍스트
    var emptyUsedText: String {
        switch self {
        case .sent:
            return "아직 보낸 쿠폰이\n없어요!"
            
        case .received:
            return "아직 받은 쿠폰이\n없어요!"
        }
    }
}

/// 미사용 - 사용완료
enum CouponUsageTab: CaseIterable {
    case unused
    case used
    
    /// coupon.isUsed
    var isUsed: Bool {
        switch self {
        case .unused:
            return false
        case .used:
            return true
        }
    }
    
    /// 미사용, 사용완료 탭 텍스트
    var segmentTitle: String {
        switch self {
        case .unused:
            return "미사용"
        case .used:
            return "사용완료"
        }
    }
}
