//
//  TemplateView.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import SwiftUI

struct BDTemplateView: View {
    
    let type: CouponTemplate = .orange
    let sender: String = "주니"
    let date: String = "2025.06.01"
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                //                Text("From. \(viewModel.coupon.senderName)")
                Text("From. \(sender)")
                    .font(.sb3)
                    .foregroundStyle(Color.textTitle)
                Text("\(date)까지")
                    .font(.r3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer(minLength: 0)
            
            Rectangle()
                .frame(width: 150, height: 150)
            
            Spacer(minLength: 0)
            
            Text("함께 만나서 사용할 쿠폰 입력해주세요!")
                .frame(maxWidth: .infinity)
                .font(.sb4)
                .foregroundStyle(Color.textTitle)
                .multilineTextAlignment(.center)
                .lineLimit(3)
        }
        .frame(minHeight: 430)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 17)
        .padding(.top, 31)
        .padding(.bottom, 35)
        .background {
            VStack(spacing: 0) {
                HStack {
                    Circle().foregroundStyle(type.pointColor[0].opacity(0.8))
                        .blur(radius: 75)
                        .frame(width: 123, height: 123)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 37)
                HStack {
                    Circle().foregroundStyle(type.pointColor[1].opacity(0.5))
                        .blur(radius: 75)
                        .frame(width: 204, height: 204)
                        .padding(.leading, -18)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Circle().foregroundStyle(type.pointColor[2].opacity(0.5))
                        .blur(radius: 75)
                        .frame(width: 204, height: 204)
                        .padding(.trailing, -40)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .overlay(RoundedRectangle(cornerRadius: 30).stroke(LinearGradient.templateStroke1, lineWidth: 1))
    }
}

#Preview {
    BDTemplateView()
}
