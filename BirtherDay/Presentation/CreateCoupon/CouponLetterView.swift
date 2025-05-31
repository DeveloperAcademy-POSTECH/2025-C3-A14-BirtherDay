//
//  CouponLetterView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct CouponLetterView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    @State private var letterContent: String = ""
    @State private var isKeyboardVisible: Bool = false
    
    // CouponCreationData에서 저장된 쿠폰 데이터를 가져옴
    private var couponCreationData: CouponCreationData {
        navPathManager.couponCreationData
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
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 40)
                
                // 실시간 카드 프리뷰
                CouponCardPreview(
                    template: couponCreationData.template ?? .purple,
                    senderName: couponCreationData.senderName ?? "보내는 사람",
                    expireDate: couponCreationData.expireDate ?? Date(),
                    couponTitle: couponCreationData.couponTitle ?? "쿠폰명을 입력해주세요",
                    dateFormatter: dateFormatter
                )
                .frame(maxWidth: 200, maxHeight: 280)
                
                Spacer()
                    .frame(height: 40)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("편지를 작성해주세요")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    // 편지 내용 입력 (멀티라인)
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $letterContent)
                            .font(.system(size: 16))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(.white)
                            .cornerRadius(10)
                            .frame(minHeight: 200)
                        
                        // placeholder 텍스트
                        if letterContent.isEmpty {
                            Text("편지 작성 중...")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 18)
                                .allowsHitTesting(false)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 80)
            }
            
            Spacer()
            
            // 다음 버튼
            Button(action: {
                // 편지 내용을 couponCreationData에 저장
                navPathManager.couponCreationData.letterContent = letterContent
                
                // 다음 화면으로 이동 (사진 선택 화면)
                navPathManager.pushCreatePath(.couponPicture)
            }) {
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
            }
            .buttonStyle(BDButtonStyle(buttonType: isFormValid ? .activate : .deactivate))
            .disabled(!isFormValid)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.96, green: 0.95, blue: 1))
        .contentShape(Rectangle()) // 배경 전체가 터치 가능하도록 설정
        .onTapGesture {
            // 배경 터치 시 키보드 내리기
            hideKeyboard()
        }
        .navigationTitle("편지 작성하기")
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
        .overlay(
            // 키보드가 올라왔을 때 상단에 글래스모피즘 효과
            VStack {
                if isKeyboardVisible {
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(height: 150) // status bar + navigation bar 높이
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 0.5)
                    }
                    .ignoresSafeArea(.all, edges: .top)
                }
                Spacer()
            },
            alignment: .top
        )
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                isKeyboardVisible = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                isKeyboardVisible = false
            }
        }
        .onAppear {
            setupNavigationBarAppearance()
            // 이미 입력된 편지 내용이 있다면 불러오기
            if let existingLetterContent = couponCreationData.letterContent {
                letterContent = existingLetterContent
            }
        }
    }
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.clear
        appearance.shadowImage = UIImage()
        appearance.shadowColor = UIColor.clear
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    // 키보드 숨기기 함수
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    CouponLetterView()
        .environmentObject(BDNavigationPathManager())
}
