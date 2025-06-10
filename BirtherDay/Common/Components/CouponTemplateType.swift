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
            return Color(hex: "F8F5FF")
            
        case .money:
            return Color(hex: "FFF7FF")
            
        case .cake:
            return Color(hex: "FFF7FF")
        }
    }
    
    /// 배경 그라디언트 색상
    var backgroundPointColor: [Color] {
        switch self {
        case .heart:
            return [
                Color(hex: "F786FF").opacity(0.8),
                Color(hex: "86BEFF").opacity(0.5),
                Color(hex: "AA86FF").opacity(0.5)
            ]
            
        case .money:
            return [
                Color(hex: "FFD586").opacity(0.8),
                Color(hex: "FFD586").opacity(0.8),
                Color(hex: "FFD586").opacity(0.8)
            ]
            
        case .cake:
            return [
                Color(hex: "FFD586").opacity(0.8),
                Color(hex: "FFD586").opacity(0.8),
                Color(hex: "FFD586").opacity(0.8)
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
    
    /// 쿠폰 겉배경 색상
    var backgroundColor: Color {
        switch self {
        case .heart:
            return Color(hex: "F6F2FF")
        case .money:
            return Color(hex: "FFF4F4")
        case .cake:
            return Color(hex: "FFF4F4")
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
    
    // BDMiniCoupon
    var miniCouponBackgroundColor: Color {
        switch self {
        
        case .heart:
            return Color(hex: "E5ECFF")
        case .money:
            return Color.mainViolet100
        case .cake:
            return Color.mainViolet100
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
    
    // TODO: - 대응 가능성 있음.
    /// mini 점선 색상
    var miniDashLineColor: Color {
        switch self {
        case .heart:
            return Color(hex: "B6D6FF")
            
        case .money:
            return Color(hex: "FFC68F")
        case .cake:
            return Color(hex: "FFC68F")
        }
    }
}
