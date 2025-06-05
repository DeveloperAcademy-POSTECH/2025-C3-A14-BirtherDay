//
//  BirtherDayApp.swift
//  BirtherDay
//
//  Created by Rama on 5/28/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKShare

@main
struct BirtherDayApp: App {
    
    init() {
        // KAKAO SDK 초기화
        KakaoSDK.initSDK(appKey: KakaoConfig.NATIVE_APP_KEY)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light) // 라이트모드 고정
                .onOpenURL { url in
                    if ShareApi.isKakaoTalkSharingUrl(url) {
                        // TODO: - 쿠폰 사용 완료 Modal 창 띄우기
                        print("카카오톡 공유 URL 처리: \(url)")
                    }
                }
        }
    }
}
