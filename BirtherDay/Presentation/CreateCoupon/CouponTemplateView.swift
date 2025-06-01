//
//  CouponTemplateView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponTemplateView {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var viewModel: CreateCouponViewModel
    @State private var selectedTemplate: CouponTemplate = .purple
}

// MARK: - Main View
extension CouponTemplateView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 60)
            
            titleSection // 원하는 쿠폰 디자인을 선택해 주세요 뷰
            
            Spacer()
                .frame(height: 80)
            
            templateImageSection // 템플릿 이미지 뷰
            
            Spacer()
                .frame(height: 120)
            
            TemplateSelectionButtons( // 템플릿 선택 버튼: 노랑 or 파랑 뷰
                selectedTemplate: $selectedTemplate
            )
            
            Spacer()
            
            nextButton // 다음 버튼
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .onAppear {
            loadExistingTemplate()
        }
    }
}

// MARK: - View Components
extension CouponTemplateView {
    private var titleSection: some View {
        Text("원하는 쿠폰 디자인을\n선택해주세요")
            .font(.system(size: 20, weight: .bold))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .lineSpacing(4)
    }
    
    private var templateImageSection: some View {
        Group {
            if selectedTemplate == .purple {
                Image("cardTemplate1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
            } else {
                Image("cardTemplate2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: 200)
            }
        }
    }
    
    private var nextButton: some View {
        Button(action: {
            viewModel.selectTemplate(selectedTemplate)
            navPathManager.pushCreatePath(.couponInfo)
        }) {
            Text("다음")
                .font(.system(size: 18, weight: .semibold))
        }
        .buttonStyle(BDButtonStyle(buttonType: .activate))
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

// MARK: - Methods
extension CouponTemplateView {
    private func loadExistingTemplate() {
        if let existingTemplate = viewModel.couponCreationData.template {
            selectedTemplate = existingTemplate
        }
    }
}

// MARK: - Template Selection Component
struct TemplateSelectionButtons: View {
    @Binding var selectedTemplate: CouponTemplate
    
    var body: some View {
        HStack(spacing: 24) {
            TemplateButton(
                color: Color(red: 1.0, green: 0.9, blue: 0.5),
                isSelected: selectedTemplate == .purple,
                action: { selectedTemplate = .purple }
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
                            Color(red: 0.7, green: 0.6, blue: 0.9) :
                            Color.clear,
                            lineWidth: 3
                        )
                )
        }
    }
}

// MARK: - Button Style
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
    CouponTemplateView(viewModel: CreateCouponViewModel())
        .environmentObject(BDNavigationPathManager())
}
