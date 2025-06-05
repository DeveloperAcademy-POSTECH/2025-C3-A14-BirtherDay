//
//  CouponShareCompleteView.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 6/4/25.
//

import SwiftUI

struct CouponShareCompleteView: View {
    @EnvironmentObject var navPathManager: BDNavigationPathManager
    
    var body: some View {
        ZStack {
            Color.mainViolet50.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("쿠폰 공유가 완료 되었어요!")
                        .font(.b3)
                        .padding(.bottom, 12)
                    
                    Text("생일자와 만나 쿠폰을 사용하며\n생일 축하를 함께해요")
                        .font(.m2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.textCaption1)
                        .padding(.bottom, 44)
                
                    Image("Conpetti2")
                        .resizable()
                        .frame(width: 235, height: 235)
                }
                
                Spacer()
                
                Button {
                    // TODO: - 쿠폰 상세 페이지로 이동하는 코드로 수정 예정
                    navPathManager.goToRoot()
                } label: {
                    Text("완료")
                        .font(.sb1)
                        .foregroundStyle(Color.white)
                }
                .buttonStyle(BDButtonStyle(buttonType: .activate))
            }
            .padding(
                EdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16)
            )

        }
    }
}

#Preview {
    CouponShareCompleteView()
}
