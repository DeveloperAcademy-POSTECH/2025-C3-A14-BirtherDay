//
//  ContentView.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI

struct TestView: View {
    
    private let couponService: CouponService = CouponService()
    
    var body: some View {
        VStack {
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
        }
        .padding()
    }
}

#Preview {
    TestView()
}
