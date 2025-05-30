//
//  CouponTemplateView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

//                Button(action: {
//                    navPathManager.addCreatePath(.couponInfo)
//                }) {
//                    Text("Move To CouponInfo")
//                }

struct CouponTemplateView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20){ // 화면 전체
                HStack { // 상단 바
                    Button(action: {
                        navPathManager.popPath()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Text("쿠폰 디자인 선택")
                    Spacer()
                }
                
                Text("원하는 쿠폰 디자인을\n선택해주세요")
                Image("cardTemplate1")
                
                HStack(spacing: 33){
                    Circle()
                        .fill(Color(red: 0.99, green: 0.9, blue: 0.65))
                        .frame(width: 48, height: 48)
                    Circle()
                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(width: 48, height: 48)
                }
                
                Button(action: {
                    
                }) {
                    Text("다음")
                }.buttonStyle(BDButtonStyle(buttonType: .activate))
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
            .background(Color(red: 0.96, green: 0.95, blue: 1))
        }
    }
}


enum BDButtonType {
   case activate
   case deactivate
    
   var backgroundColor: Color {
       switch self {
       case .activate:
           return Color(red: 0.5, green: 0.31, blue: 0.85)
       case .deactivate:
           return Color(red: 0.9, green: 0.9, blue: 0.9)
       }
   }
}


struct BDButtonStyle: ButtonStyle {
    let buttonType: BDButtonType
    
    init(buttonType: BDButtonType) {
        self.buttonType = buttonType
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(buttonType.backgroundColor)
            .clipShape(Capsule())
    }
}


#Preview {
    CouponTemplateView()
        .environmentObject(BDNavigationPathManager())
}
