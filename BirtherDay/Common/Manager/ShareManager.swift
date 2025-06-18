//
//  ShareManager.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 6/5/25.
//
import Foundation
import SwiftUI

import KakaoSDKShare
import KakaoSDKTemplate

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }

    public var image: Image
    public var caption: String
}

struct ShareData {
    var photo: Photo?
    var message: String
    
    init(photo: Photo?, message: String) {
        self.photo = photo
        self.message = message
    }
    
    mutating func setPhoto(_ photo: Photo) {
        self.photo = photo
    }
}

enum ShareType: String {
    case coupon
}

final class ShareManager {
    var template: CouponTemplate
    var message: String
    var params: [String: String]
    var shareType: ShareType
    
    var imageUrl: String
    var urlScheme: String
    var webUrl: String         // 일반 공유용 추가
    var buttonTitle: String
    var iosExecutionParams: [String: String]
    
    init(message: String, params: [String: String], template: CouponTemplate, shareType: ShareType) {
        self.message = message
        self.params = params
        self.shareType = shareType
        self.template = template
        self.iosExecutionParams = [:]
        
        for (key, value) in params {
            self.iosExecutionParams[key] = value
        }
        
        switch self.shareType {
        case .coupon:
            self.buttonTitle = "생일 쿠폰 확인하기"
            self.urlScheme = "kakao\(KakaoConfig.NATIVE_APP_KEY)://kakaolink"
            self.webUrl = "birtherday://coupon/\(params["couponId"] ?? "")"  // 커스텀 스키마
            self.imageUrl = self.template.sharePreviewUrl
        }
    }
    
    func shareToKakao() {
        let content = createContent()
        let buttons = createButtons()
        let template = FeedTemplate(
          content: content,
          buttons: buttons
        )
        
        // 카카오톡 공유하기
        if ShareApi.isKakaoTalkSharingAvailable() {
          ShareApi.shared.shareDefault(templatable: template) { result, error in
            if let error = error {
              print("공유 실패: \(error)")
              return
            }
            
            if let url = result {
              DispatchQueue.main.async {
                UIApplication.shared.open(url.url, options: [:], completionHandler: nil)
              }
            }
          }
        } else {
          // 카카오톡 미설치시 웹 공유 띄우기
          if let url = ShareApi.shared.makeDefaultUrl(templatable: template) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
          } else {
            print("공유 URL 생성 실패")
          }
        }
    }
    
    // Content 객체 생성
     private func createContent() -> Content {
         return Content(
             title: self.message,
             imageUrl: URL(string: self.imageUrl)!,
             link: Link(
                 mobileWebUrl: URL(string: self.urlScheme),
                 iosExecutionParams: self.iosExecutionParams
             )
         )
     }
     
     // Button 객체 생성
     private func createButtons() -> [KakaoSDKTemplate.Button] {
         return [
             Button(
                 title: self.buttonTitle,
                 link: Link(
                     iosExecutionParams: self.iosExecutionParams
                 )
             )
         ]
     }
    
    // ShareLink에 필요한 데이터를 반환하는 메소드
    func getShareLinkData() -> ShareData {
        let newMessage = "\(self.message)\n\(self.urlScheme)"
        var shareData = ShareData(photo: nil, message: newMessage)
        
        switch self.shareType {
        case .coupon:
            shareData.setPhoto(Photo(image: Image(self.template.sharePreviewImage), caption: ""))
        }
        
        return shareData
    }
    
    // 웹 공유용 데이터 반환 메서드 추가
    func getWebShareLinkData() -> ShareData {
        let newMessage = "\(self.message)\n\(self.webUrl)"  // 커스텀 URL 사용
        var shareData = ShareData(photo: nil, message: newMessage)
        
        switch self.shareType {
        case .coupon:
            shareData.setPhoto(Photo(image: Image(self.template.sharePreviewImage), caption: ""))
        }
        
        return shareData
    }
}
