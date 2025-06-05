//
//  CouponDetailViewModel.swift
//  BirtherDay
//
//  Created by Soop on 5/30/25.
//

import Foundation
import SwiftUI

//
@Observable
class CouponDetailViewModel {
    var coupon: RetrieveCouponResponse? = .stub01
    

}

extension CouponDetailViewModel {
    func loadCouponDetail() {
        print("CouponDetailViewModel - loadCouponDetail()")
    }
}
