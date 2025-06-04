//
//  HomeViewModel.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/3/25.
//

import Foundation
import SwiftUI

//@Observable
class HomeViewModel: ObservableObject {
    @Published var mockCoupons: [Coupon] = [
        Coupon(
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
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .orange,
            couponTitle: "성수동 오마카세\n내가 쏜닿ㅎㅎ 가자~",
            letter: "특별한 날에 딱이야!",
            imageList: [],
            senderName: "길지훈",
            expireDate: Date().addingTimeInterval(86400 * 5),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .blue,
            couponTitle: "🍷와인바 1병 함께 하기\n청담 와인루프탑",
            letter: "분위기 있게 한 잔 어때?",
            imageList: [],
            senderName: "지민",
            expireDate: Date().addingTimeInterval(86400 * 10),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .blue,
            couponTitle: "🛍 코엑스 쇼핑 데이\n10만원 한도!",
            letter: "갖고 싶은 거 골라!",
            imageList: [],
            senderName: "은지",
            expireDate: Date().addingTimeInterval(86400 * 15),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .blue,
            couponTitle: "🎬 용산 아이맥스\n팝콘 세트 포함",
            letter: "보고 싶던 영화 같이 보자!",
            imageList: [],
            senderName: "찬우",
            expireDate: Date().addingTimeInterval(86400 * 7),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .orange,
            couponTitle: "🎮 PC방 5시간 이용권\n치킨도 내가 쏨",
            letter: "게임하다 배고프면 치킨!",
            imageList: [],
            senderName: "태형",
            expireDate: Date().addingTimeInterval(86400 * 2),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .blue,
            couponTitle: "🍽 삼청동 브런치 투어\n카페 2곳 포함",
            letter: "우리 힐링하자 ☕️",
            imageList: [],
            senderName: "소영",
            expireDate: Date().addingTimeInterval(86400 * 20),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .blue,
            couponTitle: "🏞 남산 야경 드라이브\n야식은 내가 책임질게",
            letter: "도란도란 수다도 필수!",
            imageList: [],
            senderName: "현우",
            expireDate: Date().addingTimeInterval(86400 * 8),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .blue,
            couponTitle: "🧖‍♀️ 찜질방 데이\n찜질+계란+식혜 세트",
            letter: "하루 푹 쉬자~",
            imageList: [],
            senderName: "다현",
            expireDate: Date().addingTimeInterval(86400 * 6),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .orange,
            couponTitle: "🎡 롯데월드 자유이용권\n1일 데이트권",
            letter: "재밌게 놀자!!",
            imageList: [],
            senderName: "민재",
            expireDate: Date().addingTimeInterval(86400 * 14),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        ),
        Coupon(
            couponId: UUID().uuidString,
            sender: UUID(),
            receiver: nil,
            template: .blue,
            couponTitle: "🌊 속초 당일치기 여행\n기름값 내가 낼게!",
            letter: "바다 보러가자 🌴",
            imageList: [],
            senderName: "윤서",
            expireDate: Date().addingTimeInterval(86400 * 12),
            thumbnail: UIImage(),
            isUsed: false,
            createdDate: Date()
        )
    ]
}
