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

struct CouponData {
    var template: CouponTemplate
    var couponTitle: String
    var senderName: String
    var expireDate: Date
    var letterContent: String
    var selectedItems: [PhotosPickerItem] = []
    var selectedImages: [UIImage] = []
    var uploadedImagePaths: [String] = []
    
    init() {
        self.template = .heart
        self.couponTitle = ""
        self.senderName = ""
        self.letterContent = ""
        self.expireDate = Date()
    }
}

class CreateCouponViewModel: ObservableObject {
    @Published var couponData = CouponData()
    
    var couponForRequest: InsertCouponRequest? {
        buildCouponForRequest()
    }
    
    var couponForResponse: RetrieveCouponResponse? {
        buildCouponForResponse()
    }
    
    private let fileService: FileService
    private let couponService: CouponService
    
    init(
        fileService: FileService = FileService(),
        couponService: CouponService = CouponService()
    ) {
        self.fileService = fileService
        self.couponService = couponService
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
    
    func uploadCoupon() async {
        if let couponForRequest = couponForRequest {
            do {
                _ = try await couponService.insertCoupon(couponForRequest)
            } catch {
                print("쿠폰 등록 실패: \(error.localizedDescription)")
            }
        } else {
            print("쿠폰 등록 실패: 데이터가 모두 입력되지 않음")
        }
    }
    
    func resetCouponData() {
        couponData = CouponData()
    }
    
    func buildCouponForRequest() -> InsertCouponRequest? {
        let template = couponData.template
        let couponTitle = couponData.couponTitle
        let senderName = couponData.senderName
        let expireDate = couponData.expireDate
        let letter = couponData.letterContent
        
        guard let senderId = SupabaseManager.shared.client.auth.currentSession?.user.id.uuidString
        else {
            return nil
        }
        
        return InsertCouponRequest(
            senderId: senderId,
            senderName: senderName,
            template: template,
            title: couponTitle,
            letter: letter,
            imageList: couponData.uploadedImagePaths,
            thumbnail: "",
            deadline: expireDate,
            isUsed: false
        )
    }
    
    func buildCouponForResponse() -> RetrieveCouponResponse? {
        let template = couponData.template
        let couponTitle = couponData.couponTitle
        let senderName = couponData.senderName
        let expireDate = couponData.expireDate
        let letter = couponData.letterContent
        
        guard let senderId = SupabaseManager.shared.client.auth.currentSession?.user.id.uuidString
        else {
            return nil
        }
        
        return RetrieveCouponResponse(
            couponId: "",
            senderId: senderId,
            senderName: senderName,
            template: template,
            title: couponTitle,
            letter: letter,
            imageList: couponData.uploadedImagePaths,
            thumbnail: "",
            deadline: expireDate,
            isUsed: false,
            createdAt: Date()
        )
    }
}
