//
//  ContentView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarded") private var isOnboarded: Bool = true
    @StateObject var bdNavigationManager = BDNavigationPathManager()
    
    var body: some View {
        Group {
            if !isOnboarded {
                OnboardingView()
            } else {
                HomeView()
                    .environmentObject(bdNavigationManager)
            }
        }
    }
}
