//
//  CreateCouponViewModel.swift
//  BirtherDay
//
//  Created by rundo on 6/1/25.
//

import Foundation
import UIKit
import SwiftUI
import PhotosUI

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
    
    init() {
        // 기본값들 설정
        self.expireDate = Date()
    }
}

class CreateCouponViewModel: ObservableObject {
    // 쿠폰 생성 과정의 모든 데이터를 하나로 관리
    @Published var couponCreationData = CouponCreationData()
    
    private let fileService: FileService
    
    @Published var selectedItems: [PhotosPickerItem] = []
    @Published var selectedImages: [UIImage] = []
    
    init(fileService: FileService = FileService()) {
        self.fileService = fileService
    }
    
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
    @MainActor
    func convertItems(oldItems: [PhotosPickerItem], newItems: [PhotosPickerItem]) {
        Task {
            selectedItems = []
            var validItems = [Data]()
            var uploadedImagePaths: [String] = []
            
            for item in newItems {
                do {
                    if let data = try await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImages.append(uiImage)
                        validItems.append(data)
                    }
                } catch {
                    print("이미지 변환 실패: \(error.localizedDescription)")
                }
            }
            
            for item in validItems {
                let fullPath = try await fileService.uploadImage(item, to: .couponDetail)
                uploadedImagePaths.append(fullPath)
            }
        }
    }
    
    /// 쿠폰 생성 데이터 초기화
    func resetCouponCreation() {
        couponCreationData = CouponCreationData()
    }
}
