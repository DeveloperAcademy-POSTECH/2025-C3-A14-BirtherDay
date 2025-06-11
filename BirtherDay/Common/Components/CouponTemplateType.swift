//
//  TemplateType.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import Foundation
import SwiftUI

enum CouponTemplate: String, Codable, Equatable {
    case heart
    case money
    case cake
    
    // BDCoupon
    /// 배경 색상
    var basicColor: Color {
        switch self {
        case .heart:
            return Color(hex: "FFF4E6") // 적용
            
        case .money:
            return Color(hex: "FEFFED") // 적용
            
        case .cake:
            return Color(hex: "FFF2EC") // 적용
        }
    }
    
    /// 배경 그라디언트 색상
    var backgroundPointColor: [Color] {
        switch self {
        case .heart:
            return [
                Color(hex: "FF86A8").opacity(0.8), // 적용
                Color(hex: "FFAE86").opacity(0.5), // 적용
                Color(hex: "FF86B6").opacity(0.5) // 적용
            ]
            
        case .money:
            return [
                Color(hex: "A4FF86").opacity(0.8), // 적용
                Color(hex: "86FFDD").opacity(0.5), // 적용
                Color(hex: "D1FF86").opacity(0.5) // 적용
            ]
            
        case .cake:
            return [
                Color(hex: "FFAE5D").opacity(0.8), // 적용
                Color(hex: "FFED86").opacity(0.5), // 적용
                Color(hex: "FFAE5D").opacity(0.5) // 적용
            ]
        }
    }
    
    /// 외곽선 색상
    var strokeColor: LinearGradient {
        switch self {
        case .heart:
            return LinearGradient.heartTemplateStroke
            
        case .money:
            return LinearGradient.moneyTemplateStroke
            
        case .cake:
            return LinearGradient.cakeTemplateStroke
        }
    }
    
    /// 점선 색상
    var dashLineColor: Color {
        switch self {
        case .heart:
            return Color(hex: "B6D6FF")
            
        case .money:
            return Color(hex: "FFC68F")
            
        case .cake:
            return Color(hex: "FFC68F")
        }
    }
    
    /// 생성완료시 쿠폰 겉에 아예 배경 색상
    var backgroundColor: Color {
        switch self { 
        case .heart:
            return Color(hex: "FFF4F4") // 적용
        case .money:
            return Color(hex: "ECF6E2") // 적용
        case .cake:
            return Color(hex: "FFF6EB") // 적용
        }
    }
    
    /// 하단 버튼 배경에 적용되는 그라디언트
    var buttonBackgroundColor: LinearGradient {
        switch self {
        case .heart:
            LinearGradient.heartButtonBackground
        case .money:
            LinearGradient.moneyButtonBackground
        case .cake:
            LinearGradient.cakeButtonBackground
        }
    }
    
    var miniCouponImage: SwiftUI.Image {
        switch self {
        case .heart:
            return Image("heart")
        case .money:
            return Image("money")
        case .cake:
            return Image("cake")
        }
    }
    
    /// mini 백그라운드 색상
    var miniCouponBackgroundColor: Color {
        switch self {
        
        case .heart:
            return Color(hex: "FFEBEA")
        case .money:
            return Color(hex: "F3FFE6")
        case .cake:
            return Color(hex: "FFEDD7")
        }
    }
    
    /// mini 점선 색상
    var miniDashLineColor: Color {
        switch self {
        case .heart:
            return Color(hex: "FFC8C8")
        case .money:
            return Color(hex: "C5EFD3")
        case .cake:
            return Color(hex: "FFCC9F")
        }
    }
    
    var sharePreviewImage: String {
        switch self {
        case .heart:
            return "HeartSharePreview"
        case .money:
            return "MoneySharePreview"
        case .cake:
            return "CakeSharePreview"
        }
    }
    
    var sharePreviewUrl: String {
        let domain = "\(SupabaseConfig.url)\(SupabaseConfig.storagePath)coupon/common/"
        switch self {
        case .heart:
            return domain + "HeartSharePreview.png"
        case .money:
            return domain + "MoneySharePreview.png"
        case .cake:
            return domain + "CakeSharePreview.png"
        }
    }
}
