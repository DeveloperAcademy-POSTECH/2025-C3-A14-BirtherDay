//
//  UserError.swift
//  BirtherDay
//
//  Created by 길지훈 on 6/5/25.
//

import Foundation

enum UserError: LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "사용자를 찾지 못했습니다."
        }
    }
}
