//
//  BDNavigationBar.swift
//  BirtherDay
//
//  Created by Rama on 6/9/25.
//

import SwiftUI

struct BDNavigationBar: ViewModifier {
    let title: String
    let onBackButtonTapped: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        onBackButtonTapped()
                    } label:{
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .onAppear { setupNavigationBarAppearance() }
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.clear

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
