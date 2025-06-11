//
//  BDMiniCoupon.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/3/25.
//

import SwiftUI

struct BDMiniCoupon: View {
    let coupon: RetrieveCouponResponse
    
    var body: some View {
        let couponUsage = coupon.isUsed
        
        if couponUsage == false {
            unusedCouponView()
        } else {
            usedCouponView()
        }
    }
    
    // MARK: - Views
    
    /// 미사용 쿠폰
    func unusedCouponView() -> some View {
        VStack(spacing: 0) {
            couponMainView()
            couponInfoView()
        }
        .foregroundStyle(coupon.template.miniCouponBackgroundColor)
    }
    
    /// 사용완료 쿠폰
    func usedCouponView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                couponInfoView()
            }
            Image("usedStamp")
        }
        .frame(width: 165)
        .foregroundStyle(coupon.template.miniCouponBackgroundColor)
    }
    
    /// 메인 쿠폰
    func couponMainView() -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 15)
            
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    
                    Spacer()
                    
                    let daysLeft = Calendar.current.dateComponents([.day], from: Date(), to: coupon.deadline).day ?? 0
                    
                    Text("D - \(max(0, daysLeft))")
                        .font(.r4)
                        .foregroundStyle(Color.mainPrimary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 100)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.mainPrimary, lineWidth: 0.5)
                        )
                        .padding(.top, 10)
                        .padding(.trailing, 9)
                }
                Spacer()
                
                //                dashedLineView(color: coupon.template.dashLineColor)
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
                coupon.template.miniCouponBackgroundColor
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
    
    /// 쿠 폰 정보
    func couponInfoView()-> some View {
        return ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 15)
            
            VStack(alignment: .leading, spacing: 0) {
                dashedLineView(color: coupon.template.miniDashLineColor)
                    .padding(.top, 1)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(coupon.title)")
                        .font(.sb1)
                        .foregroundStyle(Color.textTitle)
                        .lineSpacing(6)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    Text("From. \(coupon.senderName)")
                        .font(.r1)
                        .foregroundStyle(Color.mainPrimary)
                        //.padding(.bottom, 20)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
        }
        .frame(width: 164, height: 113)
    }
}

// (traits: .sizeThatFitsLayout)
#Preview {
    BDMiniCoupon(coupon: .stub01)
}
