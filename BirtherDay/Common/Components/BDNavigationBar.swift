//
//  BDNavigationBar.swift
//  BirtherDay
//
//  Created by Rama on 6/9/25.
//

import SwiftUI

struct BDNavigationBar: ViewModifier {
    let title: String
    let backgroundColor: UIColor
    let isCustomBackButtonHidden: Bool
    let onBackButtonTapped: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if !isCustomBackButtonHidden {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            onBackButtonTapped()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .onAppear { setNavigationBarAppearance(color: backgroundColor) }
    }
    
    private func setNavigationBarAppearance(color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
