//
//  CouponLetterView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponLetterView {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var viewModel: CreateCouponViewModel
    
    @State private var letterContent: String = ""
}

// MARK: - Main View
extension CouponLetterView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 40)
                
                cardPreviewSection // 쿠폰 실시간 보기 뷰
                
                Spacer()
                    .frame(height: 40)
                
                letterInputSection // 편지 작성 뷰
                
                Spacer()
                    .frame(height: 80)
            }
            
            Spacer()
            
            nextButton
        }
        .keyboardAware(
            navigationTitle: "편지 작성하기",
            onBackButtonTapped: {
                navPathManager.popPath()
            }
        )
        .onAppear {
            loadExistingLetter()
        }
    }
}

// MARK: - View Components
extension CouponLetterView {
    private var cardPreviewSection: some View {
        CouponCardPreview(
            template: couponCreationData.template ?? .orange,
            senderName: couponCreationData.senderName ?? "보내는 사람",
            expireDate: couponCreationData.expireDate ?? Date(),
            couponTitle: couponCreationData.couponTitle ?? "쿠폰명을 입력해주세요",
            dateFormatter: dateFormatter
        )
        .frame(maxWidth: 200, maxHeight: 280)
    }
    
    private var letterInputSection: some View {
        LetterInputField(letterContent: $letterContent)
            .padding(.horizontal, 20)
    }
    
    private var nextButton: some View {
        Button(action: {
            saveLetterAndNavigate()
        }) {
            Text("다음")
                .font(.system(size: 18, weight: .semibold))
        }
        .buttonStyle(BDButtonStyle(buttonType: isFormValid ? .activate : .deactivate))
        .disabled(!isFormValid)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
}

// MARK: - Computed Properties
extension CouponLetterView {
    private var couponCreationData: CouponCreationData {
        viewModel.couponCreationData
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. M. d"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    private var isFormValid: Bool {
        !letterContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

// MARK: - Methods
extension CouponLetterView {
    private func loadExistingLetter() {
        if let existingLetterContent = couponCreationData.letterContent {
            letterContent = existingLetterContent
        }
    }
    
    private func saveLetterAndNavigate() {
        viewModel.updateLetterContent(letterContent)
        navPathManager.pushCreatePath(.couponPicture)
    }
}

// MARK: - Letter Input Component
struct LetterInputField: View {
    @Binding var letterContent: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            inputTitle
            textEditorWithPlaceholder
        }
    }
    
    private var inputTitle: some View {
        Text("편지를 작성해주세요")
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.black)
    }
    
    private var textEditorWithPlaceholder: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $letterContent)
                .font(.system(size: 16))
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(.white)
                .cornerRadius(10)
                .frame(minHeight: 200)
            
            if letterContent.isEmpty {
                placeholderText
            }
        }
    }
    
    private var placeholderText: some View {
        Text("편지 작성 중...")
            .font(.system(size: 16))
            .foregroundColor(.gray)
            .padding(.horizontal, 16)
            .padding(.vertical, 18)
            .allowsHitTesting(false)
    }
}

#Preview {
    CouponLetterView(viewModel: CreateCouponViewModel())
        .environmentObject(BDNavigationPathManager())
}
