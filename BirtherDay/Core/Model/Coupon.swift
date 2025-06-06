//
//  File.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import SwiftUI
import PhotosUI
import UIKit

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

struct Coupon: Identifiable {
    let id = UUID().uuidString
    let couponId: String
    var sender: UUID?
    var receiver: UUID?
    var template: CouponTemplate
    var couponTitle: String
    var letter: String
    var imageList: [String]
    var senderName: String
    var expireDate: Date
    var thumbnail: UIImage?
    var isUsed: Bool
    var createdDate: Date
}

extension Coupon {
    public static var stub01: Coupon = Coupon(
        couponId: "sample-id",
        sender: UUID(),
        receiver: nil,
        template: .blue,
        couponTitle: "애슐리 디너\n1회 이용권",
        letter: "축하해!",
        imageList: [],
        senderName: "주니",
        expireDate: Date().addingTimeInterval(86400 * 60),
        thumbnail: UIImage(),
        isUsed: false,
        createdDate: Date()
    )
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

struct RetrieveCouponResponse: Hashable, Codable, Identifiable {
    var id = UUID().uuidString
    var couponId: String
    var senderId: String
    var senderName: String
    var template: CouponTemplate
    var title: String
    var letter: String
    var imageList: [String?]
    var thumbnail: String
    var deadline: Date
    var isUsed: Bool
    var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case couponId = "id"
        case senderId = "sender_id"
        case senderName = "sender_name"
        case imageList = "image_list"
        case isUsed = "is_used"
        case createdAt = "created_at"
        case template, title, letter, thumbnail, deadline
    }
}

extension RetrieveCouponResponse {
    static var stub01: RetrieveCouponResponse = {
//        guard let userId = SupabaseManager.shared.client.auth.currentSession?.user.id else {
//            fatalError("No user ID found")
//        }
        
        return .init(couponId: "", senderId: "", senderName: "프레이", template: .blue, title: "프레이가", letter: "프레이프레이프레잉이잉잉이이이이이이이잉", imageList: [], thumbnail: "", deadline: Date(), isUsed: false, createdAt: Date()
        )
    }()
}
