//
//  CouponTemplateView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponTemplateView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    var body: some View {
        VStack {
            Button(action: {
                navPathManager.pushCreatePath(.couponInfo)
            }) {
                Text("Move To CouponInfo")
            }
        }
    }
}
