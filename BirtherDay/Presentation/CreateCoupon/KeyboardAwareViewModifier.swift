//
//  KeyboardAwareViewModifier.swift
//  BirtherDay
//
//  Common keyboard handling and navigation setup
//

import SwiftUI

struct KeyboardAwareViewModifier: ViewModifier {
    @State private var isKeyboardVisible: Bool = false
    
    let navigationTitle: String
    let onBackButtonTapped: () -> Void
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.96, green: 0.95, blue: 1))
            .contentShape(Rectangle())
            .onTapGesture {
                hideKeyboard()
            }
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
            .overlay(
                VStack {
                    if isKeyboardVisible {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.white.opacity(0.8))
                                .frame(height: 100)
                            
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
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// ViewModifier를 쉽게 사용할 수 있도록 하는 View Extension
extension View {
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
