//
//  UploadError.swift
//  BirtherDay
//
//  Created by 길지훈 on 5/30/25.
//

import Foundation

enum UploadError: LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case imageUploadFailed
    case fileTooLarge
    case previewGenerationFailed
    case couponCreationFailed

    var errorDescription: String? {
        switch self {
        case .imageUploadFailed:
            return "이미지 업로드에 실패했습니다. 네트워크 상태를 확인해주세요."
        case .fileTooLarge:
            return "파일 크기가 너무 큽니다. \n ex) 5MB 이하로 첨부해주세요."
        case .previewGenerationFailed:
            return "쿠폰 미리보기를 생성하는 데 실패했습니다."
        case .couponCreationFailed:
            return "쿠폰 생성에 실패했습니다. 잠시 후 다시 시도해주세요."
        }
    }
}
