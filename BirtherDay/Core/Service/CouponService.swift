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
    
    // 쿠폰을 생성합니다.
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
        
        return res;
    }
    
    // 쿠폰을 조회합니다.
    /// - Parameter Void
    /// - Returns: `[RetrieveCouponResponse]`
    /// - Throws: 삽입 실패 또는 네트워크 오류 발생 시 예외를 던집니다.
    func retrieveCoupons(_ userId: String) async throws -> [RetrieveCouponResponse] {
        let res: [RetrieveCouponResponse] = try await client
            .from("coupon")
            .select()
            .execute()
            .value
        
        return res
    }
    
    // 쿠폰 대상자 등록
    
    // 쿠폰 사용
}
