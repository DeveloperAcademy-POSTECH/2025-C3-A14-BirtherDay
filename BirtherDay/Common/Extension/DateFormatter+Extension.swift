//
//  DateFormatter+Extension.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

import Foundation

extension DateFormatter {
    static let expiredDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
