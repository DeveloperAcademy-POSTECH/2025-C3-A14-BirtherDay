//
//  BDMiniCoupon.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/3/25.
//

import SwiftUI

struct BDMiniCoupon: View {
    let coupon: Coupon
    
    var body: some View {
        VStack(spacing: 0) {
            couponMainView()
            couponInfoView()
        }
        .foregroundStyle(coupon.template.miniCouponBackgroundColor)
    }
    
    // MARK: - Functions
    /// 메인 쿠폰
    func couponMainView()-> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 15)
            
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    
                    Spacer()
                    
                    let daysLeft = Calendar.current.dateComponents([.day], from: Date(), to: coupon.expireDate).day ?? 0
                    
                    Text("D - \(max(0, daysLeft))")
                        .font(.r4)
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
            coupon.template.miniCouponImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 90)
                .clipped()
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
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
            VStack(alignment: .leading, spacing: 4) {
                Text("\(coupon.couponTitle)")
                    .font(.sb1)
                    .foregroundStyle(Color.textTitle)
                
                Text("From. \(coupon.senderName)")
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
    BDMiniCoupon(coupon: Coupon(
        couponId: "sample-id",
        sender: UUID(),
        receiver: nil,
        template: .blue,
        couponTitle: "애슐리 디너\n1회 이용권",
        letter: "축하해!",
        imageList: [],
        senderName: "주니",
        expireDate: Date().addingTimeInterval(86400 * 60),
        thumbnail: UIImage(),
        isUsed: false,
        createdDate: Date()
    ))
}
