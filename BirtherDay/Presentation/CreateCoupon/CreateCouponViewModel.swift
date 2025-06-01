//
//  CreateCouponViewModel.swift
//  BirtherDay
//
//  Created by rundo on 6/1/25.
//

import Foundation
import UIKit
import SwiftUI

// 쿠폰 생성 과정의 모든 데이터를 관리하는 통합 구조체
struct CouponCreationData {
    // 1단계: 템플릿 선택
    var template: CouponTemplate?
    
    // 2단계: 쿠폰 정보 입력
    var couponTitle: String?
    var senderName: String?
    var expireDate: Date?
    
    // 3단계: 편지 작성
    var letterContent: String?
    
    // 4단계: 사진 선택
    var selectedPhoto: UIImage?
    
    init() {
        // 기본값들 설정
        self.expireDate = Date()
    }
}

class CreateCouponViewModel: ObservableObject {
    // 쿠폰 생성 과정의 모든 데이터를 하나로 관리
    @Published var couponCreationData = CouponCreationData()
    
    // MARK: - 데이터 업데이트 메서드
    
    /// 템플릿 선택
    func selectTemplate(_ template: CouponTemplate) {
        couponCreationData.template = template
    }
    
    /// 쿠폰 정보 업데이트
    func updateCouponInfo(title: String, senderName: String, expireDate: Date) {
        couponCreationData.couponTitle = title
        couponCreationData.senderName = senderName
        couponCreationData.expireDate = expireDate
    }
    
    /// 편지 내용 업데이트
    func updateLetterContent(_ content: String) {
        couponCreationData.letterContent = content
    }
    
    /// 사진 선택
    func selectPhoto(_ image: UIImage) {
        couponCreationData.selectedPhoto = image
    }
    
    /// 쿠폰 생성 데이터 초기화
    func resetCouponCreation() {
        couponCreationData = CouponCreationData()
    }
}
