//
//  CouponTemplateView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponTemplateView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var viewModel: CreateCouponViewModel
    @State private var selectedTemplate: CouponTemplate = .heart
        
        
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 28)
            
            titleSection() // 원하는 쿠폰 디자인을 선택해 주세요 뷰
            
            Spacer()
                .frame(height: 32)
            
            templateImageSection() // 템플릿 이미지 뷰
            
            Spacer()
                .frame(height: 34)
            
            templateSelectionButtons() // 템플릿 선택 버튼: 노랑 or 파랑 뷰
            
            Spacer()
            
            nextButton() // 다음 버튼
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mainViolet50)
        .keyboardAware()
        .bdNavigationBar(title: "쿠폰 디자인 선택", backButtonAction: navPathManager.popPath)
        .onAppear {
            loadExistingTemplate()
        }
    }
    
    func titleSection() -> some View {
        Text("원하는 쿠폰 디자인을\n선택해주세요")
            .font(.sb4)
            .multilineTextAlignment(.center)
            .lineSpacing(8)
    }
    
    func templateImageSection() -> some View {
        let imageName = switch selectedTemplate {
            case .heart: "CardHeart"
            case .money: "CardMoney"
            case .cake: "CardCake"
        }
        
        return Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxHeight: 387)
    }
    
    func nextButton() -> some View {
        Button(action: {
            viewModel.update(.template(selectedTemplate))
            navPathManager.pushCreatePath(.couponInfo)
        }) {
            Text("다음")
                .font(.system(size: 18, weight: .semibold))
        }
        .buttonStyle(BDButtonStyle(buttonType: .activate))
    }
    
    func templateSelectionButtons() -> some View {
        HStack(spacing: 30) {
            templateButton(
                color: Color.cardHeart,
                isSelected: selectedTemplate == .heart,
                action: { selectedTemplate = .heart }
            )
            
            templateButton(
                color: Color.cardMoney,
                isSelected: selectedTemplate == .money,
                action: { selectedTemplate = .money }
            )
            
            templateButton(
                color: Color.cardCake,
                isSelected: selectedTemplate == .cake,
                action: { selectedTemplate = .cake }
            )
        }
    }
    
    func templateButton(
        color: Color,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: 44, height: 44)
                .overlay(
                    Circle()
                        .stroke(
                            isSelected ?
                            Color.mainPrimary :
                            Color.clear,
                            lineWidth: 2
                        )
                )
        }
    }
    
    func loadExistingTemplate() {
        if let existingTemplate = viewModel.couponData.template {
            selectedTemplate = existingTemplate
        }
    }
}

#Preview {
    CouponTemplateView(viewModel: CreateCouponViewModel())
        .environmentObject(BDNavigationPathManager())
}
