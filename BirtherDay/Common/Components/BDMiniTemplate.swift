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
        VStack() {
            senderDateView()
            
            Spacer()
            
            if showGiftBox {
                giftBoxImage()
            }
            
            Spacer()
            
            titleView()
            
            Spacer()
                .frame(height: 9.29)
        }
        .padding(.vertical, 12.53)
        .padding(.horizontal, 11.38)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            backgroundImage(template: template) // <-- 이미지 배경 사용
        }
    }
    
    /// 에셋에 등록된 카드 배경 이미지 사용
    func backgroundImage(template: CouponTemplate) -> some View {
        Image(template == .orange ? "Card1Back" : "Card2Back")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    /// 전송자 및 만료날짜
    func senderDateView() -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("From. \(senderName)")
                .font(.system(size: 9, weight: .semibold))
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
            .frame(width: 66, height: 66)
    }
    
    /// 타이틀 뷰
    func titleView() -> some View {
        Text(couponTitle)
            .font(.system(size: 10, weight: .semibold))
            .foregroundStyle(Color.textTitle)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .minimumScaleFactor(0.8)
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
