//
//  BDMiniCoupon.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/3/25.
//

import SwiftUI

struct BDMiniCoupon: View {
    var body: some View {
        VStack(spacing: 0) {
            couponMainView()
            couponInfoView()
        }
    }
    
    // MARK: - Functions
    /// 메인 쿠폰
    func couponMainView()-> some View {
        let expireDay: String = "999"
        
        return ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.mainViolet100)
            
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Spacer()
                    
                    Text("D - \(expireDay)")
                    // TODO: - .r3로 수줭
                        .font(.r1)
                        .foregroundStyle(Color.mainPrimary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.mainPrimary, lineWidth: 0.5)
                        )
                        .padding(.top, 10)
                        .padding(.trailing, 9)
                }
                Spacer()
                
                dashedLineView(color: Color.mainViolet300)
            }
            
            Image("Card1Box")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 90)
                .clipped()
                //.padding(.horizontal, 35)

        }
        .frame(width: 165, height: 157)
    }
    
    /// 점선
    func dashedLineView(color: Color)-> some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 15, y: 0))
                path.addLine(to: CGPoint(x: 150, y: 0))
            }
            .stroke(
                Color.mainViolet100
            )
            .frame(height: 1)
            
            
            Path { path in
                path.move(to: CGPoint(x: 15, y: 0))
                path.addLine(to: CGPoint(x: 150, y: 0))
            }
            .stroke(
                color,
                style: StrokeStyle(lineWidth: 2, dash: [8, 6])
            )
            .frame(height: 1)
            
            
        }
    }
    
    /// 쿠폰 정보
    func couponInfoView()-> some View {
        let couponTitle: String = "애슐리 디너\n1회 이용권"
        let sender: String = "주니"
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.mainViolet100)
            VStack(alignment: .leading, spacing: 4) {
                Text("\(couponTitle)")
                    .font(.sb1)
                    .foregroundStyle(Color.textTitle)
                
                Text("From. \(sender)")
                    .font(.r1)
                    .foregroundStyle(Color.mainPrimary)
            }
            .padding(.horizontal, 16)
        }
        .frame(width: 164, height: 113)
    }
}

// (traits: .sizeThatFitsLayout)
#Preview {
    BDMiniCoupon()
}
