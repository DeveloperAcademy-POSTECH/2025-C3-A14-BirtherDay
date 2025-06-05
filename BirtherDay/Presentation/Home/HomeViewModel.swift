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
    
    @Published var mockCoupons: [RetrieveCouponResponse] = [
        RetrieveCouponResponse(
            couponId: "sample-id",
            senderId: UUID().uuidString,
            senderName: "주니",
            template: .blue,
            title: "애슐리 디너\n1회 이용권",
            letter: "축하해!",
            imageList: [],
            thumbnail: "", // UIImage → URL string 변환이 필요하다면 추가 처리
            deadline: Date().addingTimeInterval(86400 * 60),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "길지훈",
            template: .orange,
            title: "성수동 오마카세\n내가 쏜닿ㅎㅎ 가자~",
            letter: "특별한 날에 딱이야!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 5),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "지민",
            template: .blue,
            title: "🍷와인바 1병 함께 하기\n청담 와인루프탑",
            letter: "분위기 있게 한 잔 어때?",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 10),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "은지",
            template: .blue,
            title: "🛍 코엑스 쇼핑 데이\n10만원 한도!",
            letter: "갖고 싶은 거 골라!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 15),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "찬우",
            template: .blue,
            title: "🎬 용산 아이맥스\n팝콘 세트 포함",
            letter: "보고 싶던 영화 같이 보자!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 7),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "태형",
            template: .orange,
            title: "🎮 PC방 5시간 이용권\n치킨도 내가 쏨",
            letter: "게임하다 배고프면 치킨!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 2),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "소영",
            template: .blue,
            title: "🍽 삼청동 브런치 투어\n카페 2곳 포함",
            letter: "우리 힐링하자 ☕️",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 20),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "현우",
            template: .blue,
            title: "🏞 남산 야경 드라이브\n야식은 내가 책임질게",
            letter: "도란도란 수다도 필수!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 8),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "다현",
            template: .blue,
            title: "🧖‍♀️ 찜질방 데이\n찜질+계란+식혜 세트",
            letter: "하루 푹 쉬자~",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 6),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "민재",
            template: .orange,
            title: "🎡 롯데월드 자유이용권\n1일 데이트권",
            letter: "재밌게 놀자!!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 14),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: UUID().uuidString,
            senderId: UUID().uuidString,
            senderName: "윤서",
            template: .blue,
            title: "🌊 속초 당일치기 여행\n기름값 내가 낼게!",
            letter: "바다 보러가자 🌴",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 12),
            isUsed: false,
            createdAt: Date()
        )
    ]

}
