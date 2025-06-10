//
//  InteractionCompleteView.swift
//  BirtherDay
//
//  Created by Rama on 5/30/25.
//

import SwiftUI

struct InteractionCompleteView: View {
    
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    var body: some View {
        ZStack {
            Color.mainPrimary.ignoresSafeArea(.all)
            VStack(spacing: 12) {
                Spacer()
                
                Text("쿠폰 사용이 완료 되었어요!")
                    .font(.b3)
                
                Text("생일자와 만나 쿠폰을 사용하며\n생일축하를 함께해요")
                    .font(.m2)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                
                
                Image(.confettiIcon)
                    .padding(.top, 20)
                
                Spacer()
                
                Button {
                    navPathManager.goToRoot()
                } label: {
                    Text("완료")
                        .foregroundStyle(Color.bgDark)
                }
                .buttonStyle(BDButtonStyle(buttonType: .deactivate))
                .padding(.horizontal, 16)

            }
            .foregroundStyle(Color.bgLight)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    InteractionCompleteView()
        .environmentObject(BDNavigationPathManager())
}
