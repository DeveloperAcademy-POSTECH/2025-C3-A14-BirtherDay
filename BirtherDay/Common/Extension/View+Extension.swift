//
//  View+Extension.swift
//  BirtherDay
//
//  Created by Rama on 6/9/25.
//

import SwiftUI

extension View {
    func keyboardAware() -> some View {
        modifier(BDKeyboardHandler())
    }
    
    func bdNavigationBar(
        title: String,
        backButtonAction: @escaping () -> Void,
        color: UIColor
    ) -> some View {
        modifier(
            BDNavigationBar(
                title: title,
                onBackButtonTapped: backButtonAction,
                backgroundColor: color
            )
        )
    }
}
