//
//  DateFormatter+Extension.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import Foundation

extension DateFormatter {
    /// 예: 2024.06.10
    static let expiredDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()

    /// 예: Jun 10, 2024
    static let englishShortMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
}

