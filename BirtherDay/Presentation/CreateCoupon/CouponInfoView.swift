//
//  CouponInfoView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponInfoView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    @State private var couponTitle: String = ""
    @State private var senderName: String = ""
    @State private var selectedDate: Date = Date()
    @State private var showDatePicker: Bool = false
    
    // CouponTemplateView에서 선택된 템플릿을 받아옴
    private var selectedTemplate: CouponTemplate {
        navPathManager.couponCreationData.template ?? .purple
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
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 40)
                
                // 실시간 카드 프리뷰
                CouponCardPreview(
                    template: selectedTemplate,
                    senderName: senderName.isEmpty ? "보내는 사람" : senderName,
                    expireDate: selectedDate,
                    couponTitle: couponTitle.isEmpty ? "쿠폰명을 입력해주세요" : couponTitle,
                    dateFormatter: dateFormatter
                )
                .frame(maxWidth: 200, maxHeight: 280)
                
                Spacer()
                    .frame(height: 40)
                
                VStack(alignment: .leading, spacing: 40) {
                    
                    // 쿠폰 제목 입력
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
                    
                    // 보내는 사람 입력
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
                    
                    // 쿠폰 마감기한
                    VStack(alignment: .leading, spacing: 12) {
                        Text("쿠폰 마감기한을 설정해주세요")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Button(action: {
                            showDatePicker.toggle()
                        }) {
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
                .padding(.horizontal, 20)
                
                Spacer()
            }
            
            Spacer()
            
            // 다음 버튼
            Button(action: {
                // 쿠폰 데이터를 couponCreationData에 저장
                navPathManager.couponCreationData.couponTitle = couponTitle
                navPathManager.couponCreationData.senderName = senderName
                navPathManager.couponCreationData.expireDate = selectedDate
                
                // 다음 화면으로 이동 (편지 작성 화면)
                navPathManager.pushCreatePath(.couponLetter)
            }) {
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
            }
            .buttonStyle(BDButtonStyle(buttonType: isFormValid ? .activate : .deactivate))
            .disabled(!isFormValid)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .keyboardAware(
            navigationTitle: "쿠폰 멘트 작성하기",
            onBackButtonTapped: {
                navPathManager.popPath()
            }
        )
        .onAppear {
            // 이미 입력된 데이터가 있다면 불러오기
            let couponData = navPathManager.couponCreationData
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
        .sheet(isPresented: $showDatePicker) {
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
}

// 실시간 카드 프리뷰 뷰
struct CouponCardPreview: View {
    let template: CouponTemplate
    let senderName: String
    let expireDate: Date
    let couponTitle: String
    let dateFormatter: DateFormatter
    
    var body: some View {
        ZStack {
            // 배경 이미지
            Image(template == .purple ? "Card1Back" : "Card2Back")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            // 콘텐츠 오버레이
            VStack(spacing: 0) {
                // 카드 상단 정보
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
                
                Spacer()
                
                // 선물상자 이미지
                Image(template == .purple ? "Card1Box" : "Card2Box")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 64)
                    .padding(.vertical, 12)
                
                Spacer()
                
                // 쿠폰 제목
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
        .frame(width: 130, height: 183)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    CouponInfoView()
        .environmentObject(BDNavigationPathManager())
}
