//
//  DeepLinkError.swift
//  BirtherDay
//
//  Created by 길지훈 on 5/30/25.
//

import Foundation

enum DeepLinkError: Error, LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case invalidParam
    case couponNotFound
    case sharingFailed

    var errorDescription: String? {
        switch self {
        case .invalidParam:
            return "잘못된 링크입니다. 다시 확인해주세요."
        case .couponNotFound:
            return "해당 쿠폰을 찾을 수 없습니다."
        case .sharingFailed:
            return "공유에 실패했습니다. 잠시 후 다시 시도해주세요."
        }
    }
}
