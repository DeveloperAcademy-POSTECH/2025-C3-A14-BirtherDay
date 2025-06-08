//
//  CouponInfoView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponInfoView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    @ObservedObject var viewModel: CreateCouponViewModel
    
    @State private var couponTitle: String = ""
    @State private var senderName: String = ""
    @State private var selectedDate: Date = Date()
    @State private var showDatePicker: Bool = false
    
    // 랜덤 예시 목록
    private let randomExamples = [
        "데이트 초대 쿠폰",
        "야식 먹기 쿠폰",
        "산책 가기 쿠폰",
        "같이 영화보기 쿠폰",
        "게임 같이 하기 쿠폰"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 32)
                
                cardPreviewSection() // 쿠폰 실시간보기 뷰
                
                Spacer()
                    .frame(height: 26)
                
                inputFormSection() // 쿠폰 정보 입력(쿠폰명, 보내는 이, 마감기한) 뷰
                
                Spacer()
            }
            
            Spacer()
            
            nextButton()
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
            datePickerSheet()
        }
    }
    
    func cardPreviewSection() -> some View {
        BDMiniTemplate(
            template: selectedTemplate(),
            senderName: senderName.isEmpty ? "보내는 사람" : senderName,
            expireDate: selectedDate,
            couponTitle: couponTitle.isEmpty ? "쿠폰명을 입력해주세요" : couponTitle
        )
        .frame(width: 140, height: 183)
    }
    
    func inputFormSection() -> some View {
        VStack(alignment: .leading, spacing: 32) {
            couponTitleInput()
            senderNameInput()
            dateSelectionInput()
        }
        .padding(.horizontal, 20)
    }
    
    func nextButton() -> some View {
        Button(action: {
            saveDataAndNavigate()
        }) {
            Text("다음")
                .font(.system(size: 18, weight: .semibold))
        }
        .buttonStyle(BDButtonStyle(buttonType: isFormValid() ? .activate : .deactivate))
        .disabled(!isFormValid())
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
    
    func selectedTemplate() -> CouponTemplate {
        viewModel.couponData.template ?? .orange
    }
    
    func isFormValid() -> Bool {
        !couponTitle.isEmpty && !senderName.isEmpty
    }
    
    func loadExistingData() {
        let couponData = viewModel.couponData
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
    
    func saveDataAndNavigate() {
        viewModel.update(.info(
            title: couponTitle,
            senderName: senderName,
            expireDate: selectedDate
        ))
        navPathManager.pushCreatePath(.couponLetter)
    }
    
    // MARK: - Input Component Functions
    func couponTitleInput() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("쿠폰명을 입력해주세요")
                    .font(.sb1)
                    .foregroundColor(.black)

                Spacer()
                
                Button(action: {
                    // 랜덤으로 쿠폰명 예시 중 하나 선택
                    if let random = randomExamples.randomElement() {
                        couponTitle = random
                    }
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.m1)
                        Text("랜덤 정하기")
                            .font(.m1)
                    }
                    .foregroundColor(Color.mainPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.bgLight)
                    .cornerRadius(60)
                }
            }

            TextField("함께할 수 있는 쿠폰이라면 더 좋아요.", text: $couponTitle)
                .font(.m1)
                .padding(.horizontal, 16)
                .padding(.vertical, 13)
                .background(Color.bgLight)
                .cornerRadius(8)
        }
    }
    
    func senderNameInput() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("보내는 사람(닉네임)을 입력해주세요")
                .font(.sb1)
                .foregroundColor(.black)
            
            TextField("보내는 사람", text: $senderName)
                .font(.m1)
                .padding(.horizontal, 16)
                .padding(.vertical, 13)
                .background(Color.bgLight)
                .cornerRadius(8)
        }
    }
    
    func dateSelectionInput() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("쿠폰 마감기한을 설정해주세요")
                .font(.sb1)
                .foregroundColor(.black)
            
            Button(action: { showDatePicker.toggle() }) {
                HStack {
                    Text(DateFormatter.englishShortMonthFormatter.string(from: selectedDate))
                        .font(Font.custom("SF Pro", size: 17))
                        .foregroundColor(Color.bgDark)
                }
                .padding(.horizontal, 11)
                .padding(.vertical, 6)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(10)
            }
        }
    }
    
    // MARK: - Date Picker Sheet Function
    func datePickerSheet() -> some View {
        NavigationView {
            DatePicker("마감 날짜 선택", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .accentColor(Color.mainPrimary) // 선택된 날짜의 색상
                .padding()
                .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.height(400)])
    }
    
    // MARK: - Card Preview Functions
    func couponCardPreview(
        template: CouponTemplate,
        senderName: String,
        expireDate: Date,
        couponTitle: String,
        dateFormatter: DateFormatter
    ) -> some View {
        ZStack {
            backgroundImage(template: template)
            contentOverlay(
                template: template,
                senderName: senderName,
                expireDate: expireDate,
                couponTitle: couponTitle,
                dateFormatter: dateFormatter
            )
        }
        .frame(width: 140, height: 183)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
    
    func backgroundImage(template: CouponTemplate) -> some View {
        Image(template == .orange ? "Card1Back" : "Card2Back")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    func contentOverlay(
        template: CouponTemplate,
        senderName: String,
        expireDate: Date,
        couponTitle: String,
        dateFormatter: DateFormatter
    ) -> some View {
        VStack(spacing: 0) {
            cardHeaderInfo(senderName: senderName, expireDate: expireDate, dateFormatter: dateFormatter)
            Spacer()
            giftBoxImage(template: template)
            Spacer()
            couponTitleSection(couponTitle: couponTitle)
        }
    }
    
    func cardHeaderInfo(senderName: String, expireDate: Date, dateFormatter: DateFormatter) -> some View {
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
    
    func giftBoxImage(template: CouponTemplate) -> some View {
        Image(template == .orange ? "Card1Box" : "Card2Box")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 64, height: 64)
            .padding(.vertical, 12)
    }
    
    func couponTitleSection(couponTitle: String) -> some View {
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
