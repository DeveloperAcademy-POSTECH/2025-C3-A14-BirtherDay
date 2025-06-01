//
//  Gradient+Extension.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import SwiftUI

extension LinearGradient {
    
    // template stroke
    static let templateStroke1 = LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(hex: "FFE0AE"), location: 0.0),
                .init(color: Color(hex: "FFB896"), location: 0.53),
                .init(color: Color(hex: "FFE87E"), location: 1.0)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
}
