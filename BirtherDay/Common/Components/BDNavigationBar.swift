//
//  BDNavigationBar.swift
//  BirtherDay
//
//  Created by Rama on 6/9/25.
//

import SwiftUI

struct BDNavigationBar: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear { setNavigationBarAppearance() }
    }
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        // Back 버튼의 title 색을 .clear로 설정함으로써 숨김
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = backButtonAppearance
        
        let backIcon = UIImage(systemName: "chevron.left")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        
        appearance.setBackIndicatorImage(backIcon, transitionMaskImage: backIcon)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
