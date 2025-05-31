//
//  ContentView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

struct TestView: View {
    
    private let authService: AuthService = AuthService()
    private let couponService: CouponService = CouponService()
    
    var body: some View {
        VStack {
            Button("유저 생성 테스트") {
                Task {
                    do {
                        print("유저 생성 전")
                        let res = try await authService.signUp()
                        print(res.user.id)
                        print("유저 생성 후")
                    } catch {
                        print("유저 생성 에러")
                        print(error)
                    }
                }
            }
            Button("쿠폰 생성 테스트") {
                Task {
                    do {
                        print("쿠폰 생성 전")
                        let state = try await couponService.insertCoupon(.stub01)
                        print(state)
                        print("쿠폰 생성 후")
                    } catch {
                        print("쿠폰 생성 에러")
                        print(error)
                    }
                    
                    print("====")
                }
            }
            Button("쿠폰 조회 테스트") {
                Task {
                    do {
                        print("쿠폰 조회 전")
                        let userId = SupabaseManager.shared.client.auth.currentSession?.user.id.uuidString ?? ""
                        print(userId)
                        let state = try await couponService.retrieveCoupons(userId)
                        print(state)
                        print("쿠폰 조회 후")
                    } catch {
                        print("쿠폰 조회 에러")
                        print(error)
                    }
                    
                    print("====")
                }
            }
            Button("쿠폰 대상자 등록 테스트") {
                Task {
                    do {
                        print("쿠폰 대상자 등록 전")
                        let couponId = "182689a7-e777-47e2-80b0-cef88bc31194"
                        let userId = SupabaseManager.shared.client.auth.currentSession?.user.id.uuidString ?? ""
                        let state = try await couponService.registerReceiver(
                            couponId: couponId,
                            receiverId: userId
                        )
                        print(state)
                        print("쿠폰 대상자 등록 후")
                    } catch {
                        print("쿠폰 대상자 등록 에러")
                        print(error)
                    }
                }
            }
            Button("쿠폰 사용 테스트") {
                Task {
                    do {
                        print("쿠폰 사용 전")
                        let couponId = "182689a7-e777-47e2-80b0-cef88bc31194"
                        let state = try await couponService.useCoupon(couponId: couponId)
                        print(state)
                        print("쿠폰 사용 후")
                    } catch {
                        print("쿠폰 사용 등록 에러")
                        print(error)
                    }
                }
            }

        }
        .padding()
    }
}

#Preview {
    TestView()
}
