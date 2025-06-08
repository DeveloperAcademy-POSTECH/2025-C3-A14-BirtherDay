//
//  BDMiniTemplate.swift
//  BirtherDay
//
//  Created by Rundo on 6/8/25.
//

import SwiftUI

struct BDMiniTemplate: View {
    let template: CouponTemplate
    let senderName: String
    let expireDate: Date
    let couponTitle: String
    let showGiftBox: Bool
    
    init(
        template: CouponTemplate,
        senderName: String,
        expireDate: Date,
        couponTitle: String,
        showGiftBox: Bool = true
    ) {
        self.template = template
        self.senderName = senderName
        self.expireDate = expireDate
        self.couponTitle = couponTitle
        self.showGiftBox = showGiftBox
    }
    
    var body: some View {
        VStack(spacing: 12) {
            senderDateView()
            
            Spacer()
            
            if showGiftBox {
                giftBoxImage()
            }
            
            Spacer()
            
            titleView()
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            bluredCircleView()
        }
        .background(template.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(template.strokeColor, lineWidth: 1))
    }
    
    /// 전송자 및 만료날짜
    func senderDateView() -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("From. \(senderName)")
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color.textTitle)
            
            Text("\(DateFormatter.expiredDateFormatter.string(from: expireDate))까지")
                .font(.system(size: 9))
                .foregroundStyle(Color.textCaption1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// 선물 박스 이미지
    func giftBoxImage() -> some View {
        Image(template == .orange ? "Card1Box" : "Card2Box")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
    }
    
    /// 타이틀 뷰
    func titleView() -> some View {
        Text(couponTitle)
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(Color.textTitle)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .minimumScaleFactor(0.8)
    }
    
    /// 미니 버전 블러 원형 배경
    func bluredCircleView() -> some View {
        ZStack {
            // 좌상단 원
            VStack {
                HStack {
                    Circle()
                        .foregroundStyle(template.backgroundPointColor[0].opacity(0.6))
                        .blur(radius: 40)
                        .frame(width: 80, height: 80)
                        .offset(x: -20, y: -20)
                    Spacer()
                }
                Spacer()
            }
            
            // 우하단 원
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .foregroundStyle(template.backgroundPointColor[1].opacity(0.5))
                        .blur(radius: 35)
                        .frame(width: 100, height: 100)
                        .offset(x: 30, y: 30)
                }
            }
        }
    }
}

// MARK: - Preview Helper
extension BDMiniTemplate {
    static func fromCouponData(_ data: CouponData) -> BDMiniTemplate {
        BDMiniTemplate(
            template: data.template ?? .orange,
            senderName: data.senderName ?? "보내는 사람",
            expireDate: data.expireDate ?? Date(),
            couponTitle: data.couponTitle ?? "쿠폰명을 입력해주세요"
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        BDMiniTemplate(
            template: .orange,
            senderName: "친구",
            expireDate: Date(),
            couponTitle: "데이트 초대 쿠폰"
        )
        .frame(width: 140, height: 183)
        
        BDMiniTemplate(
            template: .blue,
            senderName: "가족",
            expireDate: Date(),
            couponTitle: "함께 영화보기 쿠폰"
        )
        .frame(width: 140, height: 183)
    }
    .padding()
}
