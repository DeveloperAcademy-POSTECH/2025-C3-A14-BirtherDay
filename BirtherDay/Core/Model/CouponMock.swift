//
//  File.swift
//  BirtherDay
//
//  Created by Rama on 5/29/25.
//

import Foundation
import UIKit

enum CouponTemplate {
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
