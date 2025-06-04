//
//  CouponShareCompleteView.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 6/4/25.
//

import SwiftUI

struct CouponShareCompleteView: View {
    var body: some View {
        ZStack {
            Color.mainViolet50.ignoresSafeArea()
            
            VStack {
                Text("쿠폰 공유가 완료 되었어요!")
                    .font(.b3)
                    .padding(.bottom, 12)
                
                // Subtitle
                Text("생일자와 만나 쿠폰을 사용하며\n생일 축하를 함께해요")
                    .font(.m2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.textCaption1)
                    .padding(.bottom, 44)
            
                // Image
                Image("Conpetti2")
                    .resizable()
                    .frame(width: 235, height: 235)
            }
            
            Spacer()
            
            // Button
        }
    }
}

#Preview {
    CouponShareCompleteView()
}
