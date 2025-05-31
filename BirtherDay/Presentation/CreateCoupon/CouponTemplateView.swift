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
        VStack(spacing: 0) { // 화면 전체
            Spacer()
                .frame(height: 60)
            
            Text("원하는 쿠폰 디자인을\n선택해주세요")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .lineSpacing(4)
            
            Spacer()
                .frame(height: 80)
            
            // 쿠폰 이미지 영역
            Image("cardTemplate1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 200, maxHeight: 200)
            
            Spacer()
                .frame(height: 120)
            
            // 색상 선택 원형 버튼들
            HStack(spacing: 24) {
                Button(action: {
                    // 첫 번째 색상 선택 액션
                }) {
                    Circle()
                        .fill(Color(red: 1.0, green: 0.9, blue: 0.5))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Circle()
                                .stroke(Color(red: 0.7, green: 0.6, blue: 0.9), lineWidth: 3)
                        )
                }
                
                Button(action: {
                    // 두 번째 색상 선택 액션
                }) {
                    Circle()
                        .fill(Color(red: 0.4, green: 0.6, blue: 1.0))
                        .frame(width: 44, height: 44)
                }
            }
            
            Spacer()
            
            // 다음 버튼
            Button(action: {
                navPathManager.pushCreatePath(.couponInfo)
            }) {
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
            }
            .buttonStyle(BDButtonStyle(buttonType: .activate))
            .padding(.bottom, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .background(Color(red: 0.96, green: 0.95, blue: 1))
        .navigationTitle("쿠폰 디자인 선택")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    navPathManager.popPath()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .medium))
                }
            }
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
   
   var textColor: Color {
       switch self {
       case .activate:
           return Color.white
       case .deactivate:
           return Color(red: 0.6, green: 0.6, blue: 0.6)
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
            .foregroundColor(buttonType.textColor)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(buttonType.backgroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    CouponTemplateView()
        .environmentObject(BDNavigationPathManager())
}
