//
//  MPCError.swift
//  BirtherDay
//
//  Created by 길지훈 on 5/30/25.
//

import Foundation

enum MPCError: Error, LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case deviceDiscoveryFailed
    case interactionTimeout
    case sessionFailed

    var errorDescription: String? {
        switch self {
        case .deviceDiscoveryFailed:
            return "주변 기기를 찾을 수 없습니다. 더 가까이 가보세요."
        case .interactionTimeout:
            return "쿠폰 사용 시간이 초과되었습니다."
        case .sessionFailed:
            return "기기 연결에 실패했습니다. 다시 시도해주세요."
        }
    }
}
