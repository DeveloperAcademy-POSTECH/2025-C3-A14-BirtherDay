//
//  CouponService.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 5/29/25.
//

import Foundation
import Supabase

final class CouponService {
    private let client = SupabaseManager.shared.client
    
    /// 쿠폰을 생성합니다.
    /// - Parameter insertCouponRequest: 삽입할 쿠폰 데이터
    /// - Returns: `PostgrestResponse<Void>` — Status Code가 포함된 응답 객체
    ///
    /// 반환 예시:
    /// ```
    /// PostgrestResponse<Void>(
    ///   status: 201  // 성공적으로 생성됨 (Created)
    /// )
    /// ```
    /// - Throws: 삽입 실패 또는 네트워크 오류 발생 시 예외를 던집니다.
    func insertCoupon(_ insertCouponRequest: InsertCouponRequest) async throws -> PostgrestResponse<Void> {
        let res = try await client
            .from("coupon")
            .insert(insertCouponRequest)
            .execute();
        
        if res.status == 201 {
            print("✅ 쿠폰 생성 성공: \(insertCouponRequest)")
        } else {
            print("⚠️ 쿠폰 생성 응답 status: \(res.status)")
        }
        
        return res;
    }
    
    /// 내가 선물 한 쿠폰을 조회합니다.
    /// - Parameter userId: 사용자 고유 식별자 (sender_id 또는 receiver_id와 일치하는 쿠폰을 조회)
    /// - Returns: `PostgrestResponse<[RetrieveCouponResponse]>` – 조회된 쿠폰 응답 (status 포함)
    /// - Throws: 조회 실패 또는 네트워크 오류 발생 시 예외를 던집니다.
    func retrieveSentCoupons(_ userId: String) async throws -> PostgrestResponse<[RetrieveCouponResponse]> {
        do {
            let res: PostgrestResponse<[RetrieveCouponResponse]> = try await client
                .from("coupon")
                .select()
                .eq("sender_id", value: userId)
                .execute()
            
            return res
        } catch {
            /// 실제 에러
            dump(error)
            
            /// 우리 앱에서의 처리를 위해 throw
            throw CouponError.serverFetchFailed
        }
    }
    
    /// 내가 선물 받은 쿠폰을 조회합니다.
    func retrieveReceivedCoupons(_ userId: String) async throws -> PostgrestResponse<[RetrieveCouponResponse]> {
        do {
            let res: PostgrestResponse<[RetrieveCouponResponse]> = try await client
                .from("coupon")
                .select()
                .eq("receiver_id", value: userId)
                .execute()
            
            return res
        } catch {
            /// 실제 에러
            dump(error)
            
            /// 우리 앱에서의 처리를 위해 throw
            throw CouponError.serverFetchFailed
        }
    }
    
    /// 내가 받은 선물 쿠폰 중, 최대 5개까지만 조회합니다.
    /// /// 내가 받은 선물 쿠폰 중, 최대 5개까지만 조회합니다.
    /// - Parameter userId: 수신자 ID
    /// - Returns: 최대 5개의 쿠폰 리스트
    func retrieveTopFiveReceivedCoupons(_ userId: String) async throws -> PostgrestResponse<[RetrieveCouponResponse]> {
        do {
            let res: PostgrestResponse<[RetrieveCouponResponse]> = try await client
                .from("coupon")
                .select()
                .eq("receiver_id", value: userId)
                .limit(5)
                .execute()
            
            return res
        } catch {
            dump(error)
            throw CouponError.serverFetchFailed
        }
    }
    
    /// 쿠폰에 수신자(receiver)를 등록합니다.
    /// - Parameters:
    ///   - couponId: 등록할 쿠폰의 고유 식별자
    ///   - receiverId: 등록할 수신자의 고유 식별자
    /// - Returns: `PostgrestResponse<Void>` – 응답 결과 (Status Code 포함)
    /// - Throws: 업데이트 실패 또는 네트워크 오류 발생 시 예외를 던집니다.
    func registerReceiver(couponId: String, receiverId: String) async throws -> PostgrestResponse<Void> {
        let res = try await client
            .from("coupon")
            .update(["receiver_id": receiverId])
            .eq("id", value: couponId)
            .execute();
        
        return res;
    }
    
    /// 쿠폰을 사용 처리(is_used = true)로 업데이트합니다.
    /// - Parameter couponId: 사용 처리할 쿠폰의 고유 식별자
    /// - Returns: `PostgrestResponse<Void>` – 응답 결과 (Status Code 포함)
    /// - Throws: 업데이트 실패 또는 네트워크 오류 발생 시 예외를 던집니다.
    func useCoupon(couponId: String) async throws -> PostgrestResponse<Void> {
        let res = try await client
            .from("coupon")
            .update(["is_used": true])
            .eq("id", value: couponId)
            .execute();
        
        return res;
    }
}
