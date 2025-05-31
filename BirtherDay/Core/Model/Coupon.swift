//
//  File.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import Foundation
import UIKit

enum CouponTemplate: String, Codable {
    case purple
    case blue
}

class Coupon: Identifiable {
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
    
    init(
        couponId: String,
        sender: UUID,
        receiver: UUID,
        template: CouponTemplate,
        couponTitle: String,
        letter: String,
        imageList: [String],
        senderName: String,
        expireDate: Date,
        thumbnail: UIImage,
        isUsed: Bool,
        createdDate: Date
    ) {
        self.couponId = couponId
        self.sender = sender
        self.receiver = receiver
        self.template = template
        self.couponTitle = couponTitle
        self.letter = letter
        self.imageList = imageList
        self.senderName = senderName
        self.expireDate = expireDate
        self.thumbnail = thumbnail
        self.isUsed = isUsed
        self.createdDate = createdDate
    }
}

class User {
    var id: String
    
    init(id: String) {
        self.id = id
        
    }
}

struct InsertCouponRequest: Encodable {
    var sender_id: String
    var sender_name: String
    var template: CouponTemplate
    var title: String
    var letter: String
    var image_list: [String]
    var thumbnail: String
    var deadline: Date
    var is_used: Bool
    
}

extension InsertCouponRequest {
    static var stub01: InsertCouponRequest = {
        guard let userId = SupabaseManager.shared.client.auth.currentSession?.user.id else {
            fatalError("No user ID found")
        }
        
        return .init(
            sender_id: userId.uuidString,
            sender_name: "프레이가",
            template: .blue,
            title: "프레잉",
            letter: "사랑하는 프레이에게",
            image_list: [],
            thumbnail: "",
            deadline: Date(),
            is_used: false
        )
    }()
}

struct RetrieveCouponResponse: Decodable {
    var id: String
    var sender_id: String
    var sender_name: String
    var template: CouponTemplate
    var title: String
    var letter: String
    var image_list: [String]
    var thumbnail: String
    var deadline: Date
    var is_used: Bool
    var created_at: Date
}