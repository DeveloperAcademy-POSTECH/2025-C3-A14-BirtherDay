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
    case share
    
   var backgroundColor: Color {
       switch self {
       case .activate:
           return Color.primary
       case .deactivate:
           return Color.gray200
       case .share:
           return Color.bgLight
       }
   }
   
   var textColor: Color {
       switch self {
       case .activate:
           return Color.bgLight
       case .deactivate:
           return Color.textCaption1
       case .share:
           return Color.primary
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
            .font(.sb1)
            .background(buttonType.backgroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
