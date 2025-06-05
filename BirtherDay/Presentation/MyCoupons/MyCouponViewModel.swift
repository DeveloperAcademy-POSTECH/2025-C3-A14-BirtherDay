//
//  MyCouponViewModel.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/5/25.
//

import Foundation

class MyCouponViewModel: ObservableObject {
    @Published var coupons: [Coupon] = []
    @Published var isLoading: Bool = false
    @Published var userError: UserError?
    @Published var couponError: CouponError?
    
    let couponService = CouponService()
    
    /// 쿠폰 조회
    func fetchCouponData() async -> [RetrieveCouponResponse] {
        /// userID 반환
        guard let userId = SupabaseManager.shared.client.auth.currentSession?.user.id.uuidString else {
            self.userError = .userNotFound
            return []
        }
        
        /// coupons 조회
        do {
            // TODO: - userId로 교체 필요! 현재는 임시 아이디값~!
            // let response = try await couponService.retrieveCoupons(userId)
            let response = try await couponService.retrieveCoupons("154dea32-8607-4418-a619-d80692456678")
            return response
        } catch {
            if let couponError = error as? CouponError {
                ErrorHandler.handle(couponError)
                self.couponError = couponError
            } else {
                print("🙈 이건 예외처리 안된곤댕~!: \(error)")
            }
        }
        
        return []
    }
    
}
