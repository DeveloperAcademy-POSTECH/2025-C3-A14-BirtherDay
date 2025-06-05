//
//  TemplateType.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import Foundation
import SwiftUI

enum CouponTemplate: String, Codable {
    case blue
    case orange
    
    // BDCoupon
    /// 배경 색상
    var basicColor: Color {
        switch self {
        case .blue:
            return Color(hex: "F8F5FF")
            
        case .orange:
            return Color(hex: "FFF7FF")
        }
    }
    
    /// 배경 그라디언트 색상
    var backgroundPointColor: [Color] {
        switch self {
        case .blue:
            return [
                Color(hex: "F786FF").opacity(0.8),
                Color(hex: "86BEFF").opacity(0.5),
                Color(hex: "AA86FF").opacity(0.5)
            ]
            
        case .orange:
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
        case .blue:
            return LinearGradient.blueTemplateStroke
            
        case .orange:
            return LinearGradient.orangeTemplateStroke
        }
    }
    
    /// 점선 색상
    var dashLineColor: Color {
        switch self {
        case .blue:
            return Color(hex: "B6D6FF")
            
        case .orange:
            return Color(hex: "FFC68F")
        }
    }
    
    /// 쿠폰 겉배경 색상
    var backgroundColor: Color {
        switch self {
            case .blue:
            return Color(hex: "F6F2FF")
        case .orange:
            return Color(hex: "FFF4F4")
        }
    }
    
    /// 하단 버튼 배경에 적용되는 그라디언트
    var buttonBackgroundColor: LinearGradient {
        switch self {
        case .blue:
            LinearGradient.blueButtonBackground
        case .orange:
            LinearGradient.orangeButtonBackground
        }
    }
    
    // BDMiniCoupon
    var miniCouponBackgroundColor: Color {
        switch self {
        
        case .blue:
            return Color(hex: "E5ECFF")
        case .orange:
            return Color.mainViolet100
        }
    }
    
    var miniCouponImage: SwiftUI.Image {
        switch self {
        case .blue:
            return Image("Card2Box")
        case .orange:
            return Image("Card1Box")
        }
    }
    
    // TODO: - 대응 가능성 있음.
    /// mini 점선 색상
    var miniDashLineColor: Color {
        switch self {
        case .blue:
            return Color(hex: "B6D6FF")
            
        case .orange:
            return Color(hex: "FFC68F")
        }
    }
}
