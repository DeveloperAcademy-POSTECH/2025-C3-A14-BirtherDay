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
    @State private var showTitleLengthWarning: Bool = false
    @State private var showSenderLengthWarning: Bool = false
    
    let maxCouponTitleLength = 25
    let maxSenderNameLength = 10
    
    // 랜덤 예시 목록
    private let randomExamples = [
        "🤤 먹고 싶은 저녁 산다",
        "🍴 오마카세 내가 쏜다 가자~",
        "🍷 와인바 함께 하기",
        "🛍 쇼핑 데이 10만원 한도!",
        "🎬 같이 영화보자 팝콘 세트 포함",
        "🎮 PC방 5시간 이용권 짜계치도 시켜줄게",
        "🍽 브런치 투어 카페 2곳 포함",
        "🏞 밤 드라이브, 기사는 나야",
        "🧖‍♀️ 찜질방 데이 계란은 내 머리로 깨",
        "🎡 놀이공원 1일 데이트권",
        "🌊 당일치기 여행 바람과 흰 천만 가져와",
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 32)
                
                cardPreviewSection()
                
                Spacer()
                    .frame(height: 26)
                
                inputFormSection()
                
                Spacer()
            }
            
            Spacer()
            
            nextButton()
        }
        .background(Color.mainViolet50)
        .keyboardAware()
        .bdNavigationBar(
            title: "쿠폰 멘트 작성하기",
            backButtonAction: navPathManager.popPath
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
        VStack(alignment: .leading, spacing: 12) {
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
        viewModel.couponData.template ?? .heart
    }
    
    func isFormValid() -> Bool {
        !couponTitle.isEmpty && !senderName.isEmpty
    }
    
    func loadExistingData() {
        let couponData = viewModel.couponData
        
        couponTitle = couponData.couponTitle
        senderName = couponData.senderName
        selectedDate = couponData.expireDate
        
    }
    
    func saveDataAndNavigate() {
        viewModel.update(.info(
            title: couponTitle,
            senderName: senderName,
            expireDate: selectedDate
        ))
        navPathManager.pushCreatePath(.couponLetter)
    }
    
    func couponTitleInput() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("쿠폰명을 입력해주세요")
                    .font(.sb1)
                    .foregroundColor(.black)

                Spacer()
                
                Button(action: {
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
            
            Spacer()
                .frame(height: 16)

            ZStack(alignment: .bottomLeading) {
                VStack(spacing: 0) {
                    TextField("함께할 수 있는 쿠폰이라면 더 좋아요.", text: $couponTitle)
                        .font(.m1)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 13)
                        .background(Color.bgLight)
                        .cornerRadius(8)
                        .onChange(of: couponTitle) {
                            if couponTitle.count > maxCouponTitleLength {
                                couponTitle = String(couponTitle.prefix(maxCouponTitleLength))
                            }
                            showTitleLengthWarning = couponTitle.count == maxCouponTitleLength
                        }
                    
                    HStack {
                        Spacer()
                        Text("\(couponTitle.count)/\(maxCouponTitleLength)")
                            .font(.custom("Pretendard", size: 10).weight(.medium))
                            .foregroundColor(couponTitle.count == maxCouponTitleLength ? .red : .gray)
                            .padding(.trailing, 4)
                            .padding(.top, 8)
                    }
                }

                if showTitleLengthWarning {
                    Text("25자 이내로 입력해주세요")
                        .font(.custom("Pretendard", size: 10).weight(.medium))
                        .foregroundColor(.red)
                        .padding(.leading, 17)
                        .padding(.top, 8)
                }
            }
        }
    }
    
    func senderNameInput() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("보내는 사람(닉네임)을 입력해주세요")
                .font(.sb1)
                .foregroundColor(.black)
            
            ZStack(alignment: .bottomLeading) {
                VStack(spacing: 0) {
                    TextField("보내는 사람", text: $senderName)
                        .font(.m1)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 13)
                        .background(Color.bgLight)
                        .cornerRadius(8)
                        .onChange(of: senderName) {
                            if senderName.count > maxSenderNameLength {
                                senderName = String(senderName.prefix(maxSenderNameLength))
                            }
                            showSenderLengthWarning = senderName.count == maxSenderNameLength
                        }
                    
                    HStack {
                        Spacer()
                        Text("\(senderName.count)/\(maxSenderNameLength)")
                            .font(.custom("Pretendard", size: 10).weight(.medium))
                            .foregroundColor(senderName.count == maxSenderNameLength ? .red : .gray)
                            .padding(.trailing, 4)
                            .padding(.top, 8)
                    }
                }
                
                if showSenderLengthWarning {
                    Text("10자 이내로 입력해주세요")
                        .font(.custom("Pretendard", size: 10).weight(.medium))
                        .foregroundColor(.red)
                        .padding(.leading, 17)
                        .padding(.top, 8)
                }
            }
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
    
    func datePickerSheet() -> some View {
        NavigationView {
            DatePicker("마감 날짜 선택", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .accentColor(Color.mainPrimary)
                .padding()
                .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.height(400)])
    }
    
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
    }
    
    func backgroundImage(template: CouponTemplate) -> some View {
        let imageName = switch template {
            case .heart: "CardBackHeart"
            case .money: "CardBackMoney"
            case .cake: "CardBackCake"
        }
        
        return Image(imageName)
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
        let imageName = switch template {
            case .heart: "heart"
            case .money: "money"
            case .cake: "cake"
        }
        
        return Image(imageName)
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
