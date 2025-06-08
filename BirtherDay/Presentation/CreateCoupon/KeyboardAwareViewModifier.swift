//
//  KeyboardAwareViewModifier.swift
//  BirtherDay
//
//  Common keyboard handling and navigation setup
//

import SwiftUI

/// 키보드 등장 여부에 따라 뷰를 조정하고,
/// 내비게이션 타이틀 및 커스텀 백버튼을 설정하는 ViewModifier입니다.
/// - 배경 터치 시 키보드를 숨깁니다.
/// - 키보드가 올라왔을 때 내비게이션 영역이 가려지지 않도록 위에 오버레이를 추가합니다.
struct KeyboardAwareViewModifier: ViewModifier {
    @State private var isKeyboardVisible: Bool = false
    
    let navigationTitle: String
    let onBackButtonTapped: () -> Void
    
    func body(content: Content) -> some View {
        content
            // 화면을 꽉 채움
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // 전체 배경색 지정
            .background(Color(red: 0.96, green: 0.95, blue: 1))
            
            // 빈 공간까지 탭 제스처 인식되도록 설정
            .contentShape(Rectangle())
            
            // 배경 탭 시 키보드 숨김
            .onTapGesture {
                hideKeyboard()
            }
            
            // 내비게이션 타이틀 및 커스텀 백 버튼 설정
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: onBackButtonTapped) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
            
            // 키보드가 올라왔을 때 상단 배경 및 구분선 오버레이
            .overlay(
                VStack {
                    if isKeyboardVisible {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color(red: 0.96, green: 0.95, blue: 1)) // 내비게이션 영역과 동일한 배경
                                .frame(height: 100)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.2)) // 얇은 구분선
                                .frame(height: 0.5)
                        }
                        .ignoresSafeArea(.all, edges: .top)
                    }
                    Spacer()
                },
                alignment: .top
            )
            
            // 키보드 등장 이벤트 감지
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    isKeyboardVisible = true
                }
            }
            
            // 키보드 사라짐 이벤트 감지
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    isKeyboardVisible = false
                }
            }
    }
    
    /// 키보드 내리는 기능
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - View 확장: 쉽게 사용하도록 modifier 확장 정의
extension View {
    /// 키보드 대응 + 내비게이션 타이틀 + 백버튼 기능을 함께 적용
    func keyboardAware(
        navigationTitle: String,
        onBackButtonTapped: @escaping () -> Void
    ) -> some View {
        modifier(KeyboardAwareViewModifier(
            navigationTitle: navigationTitle,
            onBackButtonTapped: onBackButtonTapped
        ))
    }
}
