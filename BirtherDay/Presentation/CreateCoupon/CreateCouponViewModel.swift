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

enum CouponField {
    case template(CouponTemplate)
    case info(
        title: String,
        senderName: String,
        expireDate: Date
    )
    case letter(String)
    case photos(
        images: [UIImage],
        paths: [String]
    )
}

// 쿠폰 생성 과정의 모든 데이터를 관리하는 통합 구조체
struct CouponData {
    var template: CouponTemplate?
    var couponTitle: String?
    var senderName: String?
    var expireDate: Date?
    var letterContent: String?
    var selectedItems: [PhotosPickerItem] = []
    var selectedImages: [UIImage] = []
    var uploadedImagePaths: [String] = []
    
    init() {
        self.expireDate = Date()
    }
}

class CreateCouponViewModel: ObservableObject {
    @Published var couponData = CouponData()
    
    private let fileService: FileService
    
    init(fileService: FileService = FileService()) {
        self.fileService = fileService
    }
    
    func update(_ field: CouponField) {
        switch field {
        case .template(let template):
            couponData.template = template
        case .info(
            let title,
            let senderName,
            let expireDate
        ):
            couponData.couponTitle = title
            couponData.senderName = senderName
            couponData.expireDate = expireDate
        case .letter(let letter):
            couponData.letterContent = letter
        case .photos(
            let images,
            let paths
        ):
            couponData.selectedImages = images
            couponData.uploadedImagePaths = paths
        }
    }
    
    /// 사진 업로드
    @MainActor
    func uploadImages(_ images: [UIImage]) async -> [String] {
        var uploadedPaths: [String] = []
        
        for image in images {
            if let data = image.jpegData(compressionQuality: 0.8) {
                do {
                    let fullPath = try await fileService.uploadImage(data, to: .couponDetail)
                    uploadedPaths.append(fullPath)
                    print("업로드된 이미지 경로: \(fullPath)")
                } catch {
                    print("이미지 업로드 실패: \(error.localizedDescription)")
                }
            }
        }
        return uploadedPaths
    }
    
    func deletePhoto(index: Int) {
        couponData.selectedImages.remove(at: index)
    }
    
    /// 최종 쿠폰 객체 생성
    func buildCoupon() -> Coupon? {
        guard let template = couponData.template,
              let couponTitle = couponData.couponTitle,
              let senderName = couponData.senderName,
              let expireDate = couponData.expireDate,
              let letter = couponData.letterContent else {
            print("Incomplete data, cannot build Coupon")
            return nil
        }

        return Coupon(
            couponId: UUID().uuidString,
            sender: nil,
            receiver: nil,
            template: template,
            couponTitle: couponTitle,
            letter: letter,
            imageList: couponData.uploadedImagePaths,
            senderName: senderName,
            expireDate: expireDate,
            thumbnail: nil,
            isUsed: false,
            createdDate: Date()
        )
    }
}
