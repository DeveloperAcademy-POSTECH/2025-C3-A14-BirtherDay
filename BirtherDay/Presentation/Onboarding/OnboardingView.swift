//
//  OnboardingView.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("isOnboarded") private var isOnboarded: Bool = false

    let onboardingData = [
        OnboardingPage(
            title: "내가 만든 생일 쿠폰을 선물해요",
            description: "함께 시간을 보낼 수 있는 쿠폰과\n사진, 편지를 첨부하여 생일 쿠폰을 완성해보아요",
            imageName: "onboarding1"
        ),
        OnboardingPage(
            title: "생일자와 직접 만나 사용해요",
            description: "온라인에서 주고 받는 것에서 끝나는 선물이 아닌\n직접 만나 함께 시간을 보내며 생일을 축하해요",
            imageName: "onboarding2"
        ),
        OnboardingPage(
            title: "진정한 생일 축하를 해보아요",
            description: "생일자와 실제 만남을 통한 축하를 통해,\n더욱 가까워지길 기대해요",
            imageName: "onboarding3"
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            pageTabView()
            pageIndicator()
            actionButton()
        }
        .background(Color.bgLight)
    }
    
    // MARK: - View Functions
    
    func pageTabView() -> some View {
        TabView(selection: $currentPage) {
            ForEach(0..<onboardingData.count, id: \.self) { index in
                onboardingPageView(page: onboardingData[index])
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // 페이지 스타일
        .animation(.easeInOut, value: currentPage)
    }
    
    func onboardingPageView(page: OnboardingPage) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 95)
            
            titleText(page.title)
            
            Spacer()
                .frame(height: 16)
            
            descriptionText(page.description)
            
            Spacer()
                .frame(height: 70)
            
            centerImage(page.imageName)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)  // alignment 추가
        .padding(.horizontal, 20)  // 좌우 패딩 추가
    }
    
    func titleText(_ title: String) -> some View {
        Text(title)
            .font(.b3)
            .foregroundColor(.textTitle)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 0)
    }
    
    func descriptionText(_ description: String) -> some View {
        Text(description)
            .font(.m1)
            .foregroundColor(.textCaption1)
            .multilineTextAlignment(.leading)
            .lineSpacing(4)
            .padding(.horizontal, 0)
    }
    
    func centerImage(_ imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 280, maxHeight: 280)
            .padding(.horizontal, 60)
    }
    
    func pageIndicator() -> some View {
        HStack(spacing: 8) {
            ForEach(0..<onboardingData.count, id: \.self) { index in
                indicatorDot(isActive: currentPage == index)
            }
        }
        .padding(.bottom, 40)
    }
    
    func indicatorDot(isActive: Bool) -> some View {
        Circle()
            .fill(isActive ? Color.mainPrimary : Color.gray.opacity(0.3))
            .frame(width: 8, height: 8)
            .animation(.easeInOut, value: currentPage)
    }
    
    func actionButton() -> some View {
        Button(action: handleButtonTap) {
            Text(buttonTitle())
                .font(.sb2)
        }
        .buttonStyle(BDButtonStyle(buttonType: .activate))
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
    
    func buttonTitle() -> String {
        if currentPage < onboardingData.count - 1 {
            return "다음"
        } else {
            return "시작하기"
        }
    }
    
    func handleButtonTap() {
        if currentPage < onboardingData.count - 1 {
            // 다음 페이지로 이동
            withAnimation {
                currentPage += 1
            }
        } else {
            // 홈 화면으로 이동
            isOnboarded = true
        }
    }
}

struct OnboardingPage {
    let title: String
    let description: String
    let imageName: String
}

#Preview {
    OnboardingView()
}
