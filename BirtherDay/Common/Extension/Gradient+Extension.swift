//
//  Gradient+Extension.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import SwiftUI

extension LinearGradient {
    
    // template stroke
    static let heartTemplateStroke = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "FFE0AE"), location: 0.0),
            .init(color: Color(hex: "FFB896"), location: 0.53),
            .init(color: Color(hex: "FFE87E"), location: 1.0)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let moneyTemplateStroke = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "FF7BF0"), location: 0.0),
            .init(color: Color(hex: "D0B7FF"), location: 0.34),
            .init(color: .mainViolet100, location: 0.67),
            .init(color: Color(hex: "70D9FF"), location: 1.0)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let cakeTemplateStroke = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color(hex: "FF7BF0"), location: 0.0),
            .init(color: Color(hex: "D0B7FF"), location: 0.34),
            .init(color: .mainViolet100, location: 0.67),
            .init(color: Color(hex: "70D9FF"), location: 1.0)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let heartButtonBackground = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.clear, location: 0.0),
            .init(color: Color(hex: "FFF4F4"), location: 0.2)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let moneyButtonBackground = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.clear, location: 0.0),
            .init(color: Color(hex: "F6F2FF"), location: 0.2)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let cakeButtonBackground = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.clear, location: 0.0),
            .init(color: Color(hex: "F6F2FF"), location: 0.2)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
}
