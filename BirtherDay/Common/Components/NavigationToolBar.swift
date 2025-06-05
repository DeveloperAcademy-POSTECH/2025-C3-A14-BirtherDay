//
//  NavigationToolBar.swift
//  BirtherDay
//
//  Created by Rama on 6/5/25.
//

import SwiftUI

struct NavigationToolbar: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: action) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
    }
}
