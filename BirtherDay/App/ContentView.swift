//
//  ContentView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isOnboarded") private var isOnboarded: Bool = true
    @StateObject private var bdNavigationManager = BDNavigationPathManager()
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        Group {
            if !isOnboarded {
                OnboardingView()
            } else {
                HomeView(homeViewModel: homeViewModel)
                    .environmentObject(bdNavigationManager)
            }
        }
    }
}
