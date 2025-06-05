//
//  BDButton.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

// MARK: - Button Style
enum BDButtonType {
   case activate
   case deactivate
    
   var backgroundColor: Color {
       switch self {
       case .activate:
           return Color(red: 0.5, green: 0.31, blue: 0.85)
       case .deactivate:
           return Color(red: 0.9, green: 0.9, blue: 0.9)
       }
   }
   
   var textColor: Color {
       switch self {
       case .activate:
           return Color.white
       case .deactivate:
           return Color(red: 0.6, green: 0.6, blue: 0.6)
       }
   }
}

struct BDButtonStyle: ButtonStyle {
    let buttonType: BDButtonType
    
    init(buttonType: BDButtonType) {
        self.buttonType = buttonType
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(buttonType.textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(buttonType.backgroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
