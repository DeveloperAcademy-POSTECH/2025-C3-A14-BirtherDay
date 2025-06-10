//
//  CouponLetterView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponLetterView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var viewModel: CreateCouponViewModel
    
    @State private var letterContent: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 32)
                
                cardPreviewSection() // 쿠폰 실시간 보기 뷰
                
                Spacer()
                    .frame(height: 35)
                
                letterInputSection() // 편지 작성 뷰
                
                Spacer()
                    .frame(height: 40)
            }
            
            Spacer()
            
            nextButton()
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
        }
        .keyboardAware()
        .bdNavigationBar(
            title: "편지 작성하기",
            backButtonAction: navPathManager.popPath,
            color: UIColor(
                viewModel.couponData.template.backgroundColor
            )
        )
        .background(Color.mainViolet50)
        .onAppear {
            loadExistingLetter()
        }
    }
    
    func cardPreviewSection() -> some View {
        BDMiniTemplate(
            template: viewModel.couponData.template,
            senderName: viewModel.couponData.senderName,
            expireDate: viewModel.couponData.expireDate,
            couponTitle: viewModel.couponData.couponTitle
        )
        .frame(width: 140, height: 183)
    }
    
    func letterInputSection() -> some View {
        letterInputField()
            .padding(.horizontal, 20)
    }
    
    func nextButton() -> some View {
        Button(action: {
            saveLetterAndNavigate()
        }) {
            Text("다음")
                .font(.sb1)
        }
        .buttonStyle(BDButtonStyle(buttonType: isFormValid() ? .activate : .deactivate))
        .disabled(!isFormValid())
    }
    
    func isFormValid() -> Bool {
        !letterContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func loadExistingLetter() {
        let existingLetterContent = viewModel.couponData.letterContent
        letterContent = existingLetterContent
    }
    
    func saveLetterAndNavigate() {
//        viewModel.update(.letter(letterContent))
        viewModel.update(.letter(letterContent))
        navPathManager.pushCreatePath(.couponPicture)
    }
    
    // MARK: - Letter Input Component Function
    func letterInputField() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            inputTitle()
            textEditorWithPlaceholder()
        }
    }
    
    func inputTitle() -> some View {
        Text("편지를 작성해주세요")
            .font(.sb1)
            .foregroundColor(.black)
    }
    
    func textEditorWithPlaceholder() -> some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $letterContent)
                .font(.m1)
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(.white)
                .cornerRadius(10)
                .frame(minHeight: 200)
            
            if letterContent.isEmpty {
                placeholderText()
            }
        }
    }
    
    func placeholderText() -> some View {
        Text("편지 작성 중...")
            .font(.m1)
            .foregroundColor(.gray)
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .allowsHitTesting(false)
    }
}

#Preview {
    CouponLetterView(viewModel: CreateCouponViewModel())
        .environmentObject(BDNavigationPathManager())
}
