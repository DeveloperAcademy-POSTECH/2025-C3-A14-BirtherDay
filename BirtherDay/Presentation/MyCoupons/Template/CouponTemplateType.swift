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
    
    var pointColor: [Color] {
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
    
    var strokeColor: LinearGradient {
        switch self {
        case .blue:
            return LinearGradient.blueTemplateStroke
            
        case .orange:
            return LinearGradient.orangeTemplateStroke
        }
    }
    
    var dashLineColor: Color {
        switch self {
        case .blue:
            return Color(hex: "B6D6FF")
            
        case .orange:
            return Color(hex: "FFC68F")
        }
    }
    
    var backgroundColor: Color {
        switch self {
            case .blue:
            return Color(hex: "F6F2FF")
        case .orange:
            return Color(hex: "FFF4F4")
        }
    }
}
