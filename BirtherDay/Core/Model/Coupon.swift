//
//  File.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import Foundation
import UIKit

struct Coupon: Identifiable {
    let id = UUID().uuidString
    let couponId: String
    var sender: UUID
    var receiver: UUID?
    var template: CouponTemplate
    var couponTitle: String
    var letter: String
    var imageList: [String]
    var senderName: String
    var expireDate: Date
    var thumbnail: UIImage
    var isUsed: Bool
    var createdDate: Date
}

struct InsertCouponRequest: Codable {
    var senderId: String
    var senderName: String
    var template: CouponTemplate
    var title: String
    var letter: String
    var imageList: [String]
    var thumbnail: String
    var deadline: Date
    var isUsed: Bool
    
    enum CodingKeys: String, CodingKey {
        case senderId = "sender_id"
        case senderName = "sender_name"
        case imageList = "image_list"
        case isUsed = "is_used"
        case thumbnail, deadline, letter, title, template
    }
}

extension InsertCouponRequest {
    static var stub01: InsertCouponRequest = {
        guard let userId = SupabaseManager.shared.client.auth.currentSession?.user.id else {
            fatalError("No user ID found")
        }
        
        return .init(
            senderId: userId.uuidString,
            senderName: "프레이가",
            template: .blue,
            title: "프레잉",
            letter: "사랑하는 프레이에게",
            imageList: [],
            thumbnail: "",
            deadline: Date(),
            isUsed: false
        )
    }()
}

struct RetrieveCouponResponse: Codable {
    var id: String
    var senderId: String
    var senderName: String
    var template: CouponTemplate
    var title: String
    var letter: String
    var imageList: [String]
    var thumbnail: String
    var deadline: Date
    var isUsed: Bool
    var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case senderId = "sender_id"
        case senderName = "sender_name"
        case imageList = "image_list"
        case isUsed = "is_used"
        case createdAt = "created_at"
        case template, id, title, letter, thumbnail, deadline
    }
}
