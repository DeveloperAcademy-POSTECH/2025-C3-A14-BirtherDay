//
//  ShareButtons.swift
//  BirtherDay
//
//  Created by Rama on 6/10/25.
//

import SwiftUI

struct ShareButtons: View {
    let couponId: String
    let senderName: String
    
    private var shareManager: ShareManager {
        ShareManager(
            message: "\(senderName)님의 생일쿠폰이 도착했어요.\n쿠폰함을 확인해보세요.",
            params: ["couponId": couponId],
            template: .cake,
            shareType: .coupon
        )
    }
    
    var body: some View {
        HStack(spacing: 25) {
            kakaoShareButtonView()
            moreShareButtonView()
        }
    }
    
    func kakaoShareButtonView() -> some View {
        VStack {
            Button {
                shareManager.shareToKakao()
            } label: {
                Image(.kakaoIcon)
                    .resizable()
                    .frame(
                        width: 57,
                        height: 57
                    )
            }
            
            Text("카카오톡")
                .font(.r1)
        }
    }
    
    func moreShareButtonView() -> some View {
        VStack {
            ShareLink(
                item: shareManager.getWebShareLinkData().photo!,
                message: Text(shareManager.getWebShareLinkData().message),
                preview: SharePreview(
                    "나만의 생일 쿠폰을 보내세요!"
                    , image: shareManager.getWebShareLinkData().photo!.image
                )
            ) {
                Image(.moreIcon)
                    .resizable()
                    .frame(width: 57, height: 57)
            }
            
            Text("더보기")
                .font(.r1)
        }
    }
}
//
//#Preview {
//    ShareButtons()
//}
