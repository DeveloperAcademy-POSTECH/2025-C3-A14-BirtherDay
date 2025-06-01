//
//  TemplateType.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import Foundation
import SwiftUI

enum CouponTemplate: String, Codable {
    case purple
    case blue
    case orange
    
    var pointColor: [Color] {
        switch self {
        case .purple:
            return [.purple, .purple, .purple]
        
        case .blue:
            return [.blue, .blue, .blue]
            
        case .orange:
            return [Color(hex: "FFD586").opacity(0.8), Color(hex: "FFAE86").opacity(0.5), Color(hex: "FFED86").opacity(0.5)]
        }
    }
}
