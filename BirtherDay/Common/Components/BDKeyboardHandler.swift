//
//  BDKeyboardHandler.swift
//  BirtherDay
//
//  Created by Rama on 6/9/25.
//

import SwiftUI

struct BDKeyboardHandler: ViewModifier {
    @State private var isKeyboardVisible: Bool = false
    
    func body(content: Content) -> some View {
        content
            .onTapGesture { hideKeyboard() }
            .overlay(
                VStack {
                    if isKeyboardVisible {
                        Rectangle()
                            .fill(Color(.systemGray6))
                            .frame(height: 100)
                            .ignoresSafeArea(edges: .top)
                    }
                    Spacer()
                }, alignment: .top
            )
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                withAnimation { isKeyboardVisible = true }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                withAnimation { isKeyboardVisible = false }
            }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
