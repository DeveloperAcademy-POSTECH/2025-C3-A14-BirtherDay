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
    @Published var error: CouponError?
    
    let couponService = CouponService()

    func fetchCouponData() async -> [RetrieveCouponResponse] {
        guard let userId = SupabaseManager.shared.client.auth.currentSession?.user.id.uuidString else { exit(0) }
        
        return []
    }

}
