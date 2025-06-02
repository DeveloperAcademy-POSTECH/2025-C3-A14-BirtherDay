//
//  CouponError.swift
//  BirtherDay
//
//  Created by 길지훈 on 5/30/25.
//


import Foundation

/*
 LocalizedError -> 에러를 사람이 읽을 수 있는 문장으로 설명해주는 프로토콜
 (Alert, Text를 사용할 수 있음.)

 errorDescription은 사실 위처럼 Alert, Text에 전달하기 위한 코드다.
 사용을 안한다면 없어도 return할 필요 없음.

 Identifiable -> 후에 alert 등에 사용할 때, "이 에러가 어떤 에러인지" 구분을 가능하게 함.
 (이거 채택안하면 못씀.)

 일단 cases는 대강 생각했을 때 넣었음!!
*/

enum CouponError: Error, LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case notFound
    case expired
    case alreadyUsed
    case serverFetchFailed

    var errorDescription: String? {
        switch self {
        case .notFound:
            return "쿠폰 정보를 불러올 수 없습니다."
        case .expired:
            return "이 쿠폰은 이미 만료되었습니다."
        case .alreadyUsed:
            return "이미 사용된 쿠폰입니다."
        case .serverFetchFailed:
            return "서버에서 쿠폰 정보를 가져오는 데 실패했습니다."
        }
    }
}
