//
//  HomeViewModel.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/3/25.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    
    /// fetch쿠폰 캐시용 변수
    @Published private var allCoupons: [RetrieveCouponResponse] = []
    
    @Published var coupon: RetrieveCouponResponse?
    @Published var coupons: [RetrieveCouponResponse] = []
    @Published var isLoading: Bool = false
    @Published var userError: UserError?
    @Published var couponError: CouponError?
    
    private let couponService = CouponService()
    private let authService = AuthService()
    
    func signUp() async {
        do {
            _ = try await authService.signUp()
        } catch {
            dump(error)
            fatalError("fail to signUp")
        }
    }
    
    /// 쿠폰 데이터 Fetching, 캐싱, 필터링, 최초 present
    func fetchCoupons() async {
        let fetched = await homeFetchCouponsFromService()
        self.allCoupons = fetched
        self.coupons = fetched
        self.coupons = fetched.filter { $0.isUsed == false }
    }
    
    func fetchCouponBy(couponId: String) async {
        self.coupon = await fetchCouponBy(couponId: couponId)
    }
    
    func registerReceiverToCoupon(couponId: String, userId: String) async {
        await updateReceiver(couponId: couponId, userId: userId)
    }
    
    private func updateReceiver(couponId: String, userId: String) async -> Void {
        do {
            _ = try await couponService.registerReceiver(couponId: couponId, receiverId: userId)
        } catch {
            if let couponError = error as? CouponError {
                ErrorHandler.handle(couponError)
                self.couponError = couponError
            } else {
                print("🙈 이건 예외처리 안된곤댕~!: \(error)")
            }
        }
    }
    
    private func fetchCouponBy(couponId: String) async -> RetrieveCouponResponse? {
        do {
            let response = try await couponService.retrieveCouponBy(couponId: couponId).value
            
            return response.count > 0 ? response[0] : nil
        } catch {
            if let couponError = error as? CouponError {
                ErrorHandler.handle(couponError)
                self.couponError = couponError
            } else {
                print("🙈 이건 예외처리 안된곤댕~!: \(error)")
            }
            
            return nil
        }
    }
    
    /// 쿠폰 Fetching
    private func homeFetchCouponsFromService() async -> [RetrieveCouponResponse] {
        
        // TODO: 실제 사용할 코드
        // guard let userId = SupabaseManager.shared.client.auth.currentSession?.user.id.uuidString else {
        //     self.userError = .userNotFound
        //     ErrorHandler.handle(userError!)
        //     return []
        // }
        
        do {
            // TODO: 임시 방편 - 테스트 유저아이디
            let userId = "154dea32-8607-4418-a619-d80692456678"
            let response: [RetrieveCouponResponse]
            response = try await couponService.retrieveTopFiveReceivedCoupons(userId).value
            return response
            
        } catch {
            if let couponError = error as? CouponError {
                ErrorHandler.handle(couponError)
                self.couponError = couponError
            } else {
                print("🙈 이건 예외처리 안된곤댕~!: \(error)")
            }
            return []
        }
    }
    
    @Published var mockCoupons: [RetrieveCouponResponse] = [
        RetrieveCouponResponse(
            couponId: "1",
            senderId: UUID().uuidString,
            senderName: "주니",
            template: .heart,  // blue → heart
            title: "애슐리 디너\n1회 이용권",
            letter: "축하해!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 60),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "2",
            senderId: UUID().uuidString,
            senderName: "길지훈",
            template: .money,  // orange → money
            title: "성수동 오마카세\n내가 쏜닿ㅎㅎ 가자~",
            letter: "특별한 날에 딱이야!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 5),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "3",
            senderId: UUID().uuidString,
            senderName: "지민",
            template: .cake,  // blue → cake
            title: "🍷와인바 1병 함께 하기\n청담 와인루프탑",
            letter: "분위기 있게 한 잔 어때?",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 10),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "4",
            senderId: UUID().uuidString,
            senderName: "은지",
            template: .heart,  // blue → heart
            title: "🛍 코엑스 쇼핑 데이\n10만원 한도!",
            letter: "갖고 싶은 거 골라!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 15),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "5",
            senderId: UUID().uuidString,
            senderName: "찬우",
            template: .money,  // blue → money
            title: "🎬 용산 아이맥스\n팝콘 세트 포함",
            letter: "보고 싶던 영화 같이 보자!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 7),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "6",
            senderId: UUID().uuidString,
            senderName: "태형",
            template: .cake,  // orange → cake
            title: "🎮 PC방 5시간 이용권\n치킨도 내가 쏨",
            letter: "게임하다 배고프면 치킨!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 2),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "7",
            senderId: UUID().uuidString,
            senderName: "소영",
            template: .heart,  // blue → heart
            title: "🍽 삼청동 브런치 투어\n카페 2곳 포함",
            letter: "우리 힐링하자 ☕️",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 20),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "8",
            senderId: UUID().uuidString,
            senderName: "현우",
            template: .money,  // blue → money
            title: "🏞 남산 야경 드라이브\n야식은 내가 책임질게",
            letter: "도란도란 수다도 필수!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 8),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "9",
            senderId: UUID().uuidString,
            senderName: "다현",
            template: .cake,  // blue → cake
            title: "🧖‍♀️ 찜질방 데이\n찜질+계란+식혜 세트",
            letter: "하루 푹 쉬자~",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 6),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "10",
            senderId: UUID().uuidString,
            senderName: "민재",
            template: .heart,  // orange → heart
            title: "🎡 롯데월드 자유이용권\n1일 데이트권",
            letter: "재밌게 놀자!!",
            imageList: [],
            thumbnail: "",
            deadline: Date().addingTimeInterval(86400 * 14),
            isUsed: false,
            createdAt: Date()
        ),
        RetrieveCouponResponse(
            couponId: "11",
            senderId: UUID().uuidString,
            senderName: "윤서",
            template: .money,  // blue → money
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
