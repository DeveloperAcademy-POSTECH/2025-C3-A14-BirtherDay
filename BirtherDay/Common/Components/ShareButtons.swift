//
//  ShareButtons.swift
//  BirtherDay
//
//  Created by Rama on 6/10/25.
//

import SwiftUI

struct ShareButtons: View {
    private let shareManager: ShareManager = ShareManager(
        message: "사랑하는 길님의 생일쿠폰이 도착했어요.\n쿠폰함을 확인해보세요.",
        params: ["test1": "value"],
        template: .cake,
        shareType: .coupon
    )
    
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
            Button {
                let shareLinkData = shareManager.getShareLinkData()
                ShareLink(
                    item: shareLinkData.photo!
                    , message: Text(shareLinkData.message)
                    , preview: SharePreview(
                        "",
                        image: shareLinkData.photo!.image
                    )
                )
            } label: {
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

#Preview {
    ShareButtons()
}
