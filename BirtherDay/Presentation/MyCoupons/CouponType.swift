//
//  CouponType.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/4/25.
//

import Foundation

/// 쿠폰 타입
enum CouponType: String {
    case sent
    case received
    
    var couponNavigationTitle: String {
        switch self {
        case .sent:
            return "내가 보낸 쿠폰"
            
        case .received:
            return "선물 받은 쿠폰"
        }
    }
    
    var bannerText: String {
        switch self {
        case .sent:
            return "함께 내가 보낸 쿠폰들을\n사용해보아요!"
            
        case .received:
            return "함께 내가 받은 쿠폰들을\n사용해보아요!"
        }
    }
    
    var emptyUnusedText: String {
        switch self {
        case .sent:
            return "아직 보낸 쿠폰이\n없어요!"
            
        case .received:
            return "아직 받은 쿠폰이\n없어요!"
        }
    }
    
    var emptyUsedText: String {
        switch self {
        case .sent:
            return "아직 보낸 쿠폰이\n없어요!"
            
        case .received:
            return "아직 받은 쿠폰이\n없어요!"
        }
    }
    
    var bannerImage: String {
        switch self {
        case .sent:
            return "sentImage"
            
        case .received:
            return "receivedImage"
        }
    }
}

/// 미사용 - 사용완료
enum CouponTab: String, CaseIterable {
    case unused = "미사용"
    case used = "사용 완료"
}
