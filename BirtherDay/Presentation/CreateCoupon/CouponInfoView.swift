//
//  CouponInfoView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponInfoView {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var viewModel: CreateCouponViewModel
    
    @State private var couponTitle: String = ""
    @State private var senderName: String = ""
    @State private var selectedDate: Date = Date()
    @State private var showDatePicker: Bool = false
}

// MARK: - Main View
extension CouponInfoView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 40)
                
                cardPreviewSection // 쿠폰 실시간보기 뷰
                
                Spacer()
                    .frame(height: 40)
                
                inputFormSection // 쿠폰 정보 입력(쿠폰명, 보내는 이, 마감기한) 뷰
                
                Spacer()
            }
            
            Spacer()
            
            nextButton
        }
        .keyboardAware(
            navigationTitle: "쿠폰 멘트 작성하기",
            onBackButtonTapped: {
                navPathManager.popPath()
            }
        )
        .onAppear {
            loadExistingData()
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerSheet(selectedDate: $selectedDate, showDatePicker: $showDatePicker)
        }
    }
}

// MARK: - View Components
extension CouponInfoView {
    private var cardPreviewSection: some View {
        CouponCardPreview(
            template: selectedTemplate,
            senderName: senderName.isEmpty ? "보내는 사람" : senderName,
            expireDate: selectedDate,
            couponTitle: couponTitle.isEmpty ? "쿠폰명을 입력해주세요" : couponTitle,
            dateFormatter: dateFormatter
        )
        .frame(maxWidth: 200, maxHeight: 280)
    }
    
    private var inputFormSection: some View {
        VStack(alignment: .leading, spacing: 40) {
            CouponTitleInput(couponTitle: $couponTitle)
            SenderNameInput(senderName: $senderName)
            DateSelectionInput(
                selectedDate: selectedDate,
                dateFormatter: dateFormatter,
                onTap: { showDatePicker.toggle() }
            )
        }
        .padding(.horizontal, 20)
    }
    
    private var nextButton: some View {
        Button(action: {
            saveDataAndNavigate()
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
extension CouponInfoView {
    private var selectedTemplate: CouponTemplate {
        viewModel.couponCreationData.template ?? .purple
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. M. d"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    private var isFormValid: Bool {
        !couponTitle.isEmpty && !senderName.isEmpty
    }
}

// MARK: - Methods
extension CouponInfoView {
    private func loadExistingData() {
        let couponData = viewModel.couponCreationData
        if let existingTitle = couponData.couponTitle {
            couponTitle = existingTitle
        }
        if let existingSender = couponData.senderName {
            senderName = existingSender
        }
        if let existingDate = couponData.expireDate {
            selectedDate = existingDate
        }
    }
    
    private func saveDataAndNavigate() {
        viewModel.updateCouponInfo(
            title: couponTitle,
            senderName: senderName,
            expireDate: selectedDate
        )
        navPathManager.pushCreatePath(.couponLetter)
    }
}

// MARK: - Input Components
struct CouponTitleInput: View {
    @Binding var couponTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("쿠폰명을 입력해주세요")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)

            TextField("함께할 수 있는 쿠폰이라면 더 좋아요.", text: $couponTitle)
                .font(.system(size: 16))
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(10)
        }
    }
}

struct SenderNameInput: View {
    @Binding var senderName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("보내는 사람(닉네임)을 입력해주세요")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            
            TextField("보내는 사람", text: $senderName)
                .font(.system(size: 16))
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(10)
        }
    }
}

struct DateSelectionInput: View {
    let selectedDate: Date
    let dateFormatter: DateFormatter
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("쿠폰 마감기한을 설정해주세요")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            
            Button(action: onTap) {
                HStack {
                    Text(dateFormatter.string(from: selectedDate))
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.5, green: 0.4, blue: 0.9))
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 0.5, green: 0.4, blue: 0.9))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(10)
            }
        }
    }
}

// MARK: - Date Picker Sheet
struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        NavigationView {
            DatePicker("마감 날짜 선택", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .navigationTitle("날짜 선택")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("완료") {
                            showDatePicker = false
                        }
                        .foregroundColor(Color(red: 0.5, green: 0.4, blue: 0.9))
                    }
                }
        }
        .presentationDetents([.height(500)])
        .presentationDragIndicator(.visible)
    }
}

// MARK: - Card Preview Component
struct CouponCardPreview: View {
    let template: CouponTemplate
    let senderName: String
    let expireDate: Date
    let couponTitle: String
    let dateFormatter: DateFormatter
}

extension CouponCardPreview {
    var body: some View {
        ZStack {
            backgroundImage
            contentOverlay
        }
        .frame(width: 130, height: 183)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
    
    private var backgroundImage: some View {
        Image(template == .purple ? "Card1Back" : "Card2Back")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    private var contentOverlay: some View {
        VStack(spacing: 0) {
            cardHeaderInfo
            Spacer()
            giftBoxImage
            Spacer()
            couponTitleSection
        }
    }
    
    private var cardHeaderInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("From. \(senderName)")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.black)
                Spacer()
            }
            
            HStack {
                Text("\(dateFormatter.string(from: expireDate))까지")
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
    
    private var giftBoxImage: some View {
        Image(template == .purple ? "Card1Box" : "Card2Box")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 64, height: 64)
            .padding(.vertical, 12)
    }
    
    private var couponTitleSection: some View {
        VStack(spacing: 2) {
            Text(couponTitle)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
    }
}

#Preview {
    CouponInfoView(viewModel: CreateCouponViewModel())
        .environmentObject(BDNavigationPathManager())
}
