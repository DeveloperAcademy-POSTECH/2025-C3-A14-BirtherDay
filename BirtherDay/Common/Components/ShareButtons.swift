//
//  ShareButtons.swift
//  BirtherDay
//
//  Created by Rama on 6/10/25.
//

import SwiftUI

struct ShareButtons: View {
    let couponId: String  // 추가
    
    private var shareManager: ShareManager {  // computed property로 변경
        ShareManager(
            message: "사랑하는 길님의 생일쿠폰이 도착했어요.\n쿠폰함을 확인해보세요.",
            params: ["couponId": couponId],  // 실제 couponId 사용
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
                item: shareManager.getShareLinkData().photo!,
                message: Text(shareManager.getShareLinkData().message),
                preview: SharePreview(
                    "",
                    image: shareManager.getShareLinkData().photo!.image
                )
            ) {
                Image(.moreIcon)
                    .resizable()
                    .frame(
                        width: 57,
                        height: 57
                    )
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
