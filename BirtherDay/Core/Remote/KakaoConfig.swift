//
//  KakaoConfig.swift
//  BirtherDay
//
//  Created by Donggyun Yang on 6/4/25.
//
import Foundation

enum KakaoConfig {
    static let NATIVE_APP_KEY = {
        guard let key = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String else {
            fatalError("KAKAO_NATIVE_APP_KEY")
        }
        
        return key;
    }()
}
