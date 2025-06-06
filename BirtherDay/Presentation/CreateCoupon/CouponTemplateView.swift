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
    @State private var selectedTemplate: CouponTemplate = .orange
        
        
        var body: some View {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 12)
                
                titleSection // 원하는 쿠폰 디자인을 선택해 주세요 뷰
                
                Spacer()
                    .frame(height: 32)
                
                templateImageSection // 템플릿 이미지 뷰
                
                Spacer()
                    .frame(height: 34)
                
                TemplateSelectionButtons( // 템플릿 선택 버튼: 노랑 or 파랑 뷰
                    selectedTemplate: $selectedTemplate
                )
                
                Spacer()
//                    .frame(height: 41)
                
                nextButton // 다음 버튼
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mainViolet50)
            .navigationTitle("쿠폰 디자인 선택")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .modifier(NavigationToolbar {
                navPathManager.popPath()
            })
            .onAppear {
                loadExistingTemplate()
            }
        }
        
}

// MARK: - View Components
extension CouponTemplateView {
    private var titleSection: some View {
        Text("원하는 쿠폰 디자인을\n선택해주세요")
            .font(.sb4)
            .multilineTextAlignment(.center)
            .lineSpacing(8)
    }
    
    private var templateImageSection: some View {
        Group {
            if selectedTemplate == .orange {
                Image("cardTemplate1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 387)
            } else {
                Image("cardTemplate2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 387)
            }
        }
    }
    
    private var nextButton: some View {
        Button(action: {
            viewModel.update(.template(selectedTemplate))
            navPathManager.pushCreatePath(.couponInfo)
        }) {
            Text("다음")
                .font(.system(size: 18, weight: .semibold))
        }
        .buttonStyle(BDButtonStyle(buttonType: .activate))
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

// MARK: - Methods
extension CouponTemplateView {
    private func loadExistingTemplate() {
        if let existingTemplate = viewModel.couponData.template {
            selectedTemplate = existingTemplate
        }
    }
}

// MARK: - Template Selection Component
struct TemplateSelectionButtons: View {
    @Binding var selectedTemplate: CouponTemplate
    
    var body: some View {
        HStack(spacing: 30) {
            TemplateButton(
                color: Color(red: 1.0, green: 0.9, blue: 0.5),
                isSelected: selectedTemplate == .orange,
                action: { selectedTemplate = .orange }
            )
            
            TemplateButton(
                color: Color(red: 0.4, green: 0.6, blue: 1.0),
                isSelected: selectedTemplate == .blue,
                action: { selectedTemplate = .blue }
            )
        }
    }
}

// MARK: - Template Button Component
struct TemplateButton: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
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
}

#Preview {
    CouponTemplateView(viewModel: CreateCouponViewModel())
        .environmentObject(BDNavigationPathManager())
}
