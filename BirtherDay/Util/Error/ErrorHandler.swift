//
//  ErrorHandler.swift
//  BirtherDay
//
//  Created by 길지훈 on 5/30/25.
//


import Foundation
import SwiftUI

struct ErrorHandler {
    static func handle(_ error: Error) {
        print("🧨 Error: \(error.localizedDescription)")
    
        switch error {
        case let error as CouponError:
            handleCouponError(error)

        case let error as UploadError:
            handleUploadError(error)

        case let error as MPCError:
            handleMPCError(error)

        case let error as DeepLinkError:
            handleDeepLinkError(error)

        default:
            print("❓ Unhandled Error: \(error.localizedDescription)")
        }
    }
}

private extension ErrorHandler {
    static func handleUserError(_ error: UserError) {
        switch error {
        case .userNotFound:
            print("Error: \(error) - 사용자를 찾을 수 없습니다.")
        }
    }
    
    static func handleCouponError(_ error: CouponError) {
        switch error {
        case .alreadyUsed:
            print("Error: \(error) - 이미 사용된 쿠폰입니다.")
        case .expired:
            print("Error: \(error) - 쿠폰이 만료되었습니다.")
        case .notFound:
            print("Error: \(error) - 쿠폰을 찾을 수 없습니다.")
        case .serverFetchFailed:
            print("Error: \(error) - 서버에서 쿠폰 정보를 불러오는 데 실패했습니다.")
        }
    }

    static func handleUploadError(_ error: UploadError) {
        switch error {
        case .imageUploadFailed:
            print("Error: \(error) - 이미지 업로드에 실패했습니다.")
        case .fileTooLarge:
            print("Error: \(error) - 첨부한 이미지 용량이 너무 큽니다.")
        case .previewGenerationFailed:
            print("Error: \(error) - 쿠폰 미리보기를 생성하지 못했습니다.")
        case .couponCreationFailed:
            print("Error: \(error) - 쿠폰 생성 중 오류가 발생했습니다.")
        }
    }

    static func handleMPCError(_ error: MPCError) {
        switch error {
        case .deviceDiscoveryFailed:
            print("Error: \(error) - 주변 기기를 찾을 수 없습니다. 가까이에서 다시 시도해주세요.")

        case .interactionTimeout:
            print("Error: \(error) - 연결 시간이 초과되었습니다. 다시 시도해주세요.")

        case .sessionFailed:
            print("Error: \(error) - 기기 연결 세션에 문제가 발생했습니다.")
        }
    }

    static func handleDeepLinkError(_ error: DeepLinkError) {
        switch error {
        case .invalidParam:
            print("Error: \(error) - 유효하지 않은 링크입니다.")

        case .couponNotFound:
            print("Error: \(error) - 해당 쿠폰을 찾을 수 없습니다.")

        case .sharingFailed:
            print("Error: \(error) - 쿠폰 공유에 실패했습니다. 다시 시도해주세요.")
        }
    }
}


