//
//  ContentView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI
import Foundation

// iOS SDK
import KakaoSDKShare
import KakaoSDKTemplate    // 기본 템플릿 사용 시

struct TestView: View {
    
    private let authService: AuthService = AuthService()
    private let couponService: CouponService = CouponService()
    private let fileService: FileService = FileService()
    private let shareManager: ShareManager = ShareManager(
        message: "사랑하는 길님의 생일쿠폰이 도착했어요.\n쿠폰함을 확인해보세요.", params: ["test1": "value"], shareType: .coupon
    )
    
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
                        let state = try await couponService.retrieveSentCoupons(userId)
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
            Button("이미지 업로드 테스트") {
                Task {
                    do {
                        print("이미지 업로드 전")
                        
                        guard let image = UIImage(systemName: "star"),
                              let imageData = image.jpegData(compressionQuality: 0.8) else {
                            print("이미지 변환 실패")
                            return
                        }
                        
                        let filePath = try await fileService.uploadImage(imageData,to: .couponThumbnail)
                        print("이미지 업로드 성공: \(filePath)")
                        
                        print("이미지 업로드 후")
                    } catch {
                        print("이미지 업로드 실패")
                        print(error)
                    }
                }
            }
            Button("카카오 공유 테스트") {
                shareManager.shareToKakao()
            }
        }
        .padding()
    }
}

#Preview {
    TestView()
}
