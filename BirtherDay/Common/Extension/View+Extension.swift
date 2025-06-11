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
        isBackButtonHidden: Bool = false,
        backButtonAction: @escaping () -> Void
    ) -> some View {
        modifier(
            BDNavigationBar(
                title: title,
                isCustomBackButtonHidden: isBackButtonHidden,
                onBackButtonTapped: backButtonAction
            )
        )
    }
}
