//
//  Color+Extension.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

// Color 사용 방법
// .foregroundStyle(Color.mainPrimary)


import SwiftUI

extension Color {
    // Main
    static let mainViolet50 = Color(hex: "F6F2FF")
    static let mainViolet100 = Color(hex: "f2edfb")
    static let mainViolet200 = Color(hex: "ece4f9")
    static let mainViolet300 = Color(hex: "d7c8f4")
    static let mainPrimary = Color(hex: "7f4eda")
    static let mainViolet500 = Color(hex: "7246c4")
    static let mainViolet600 = Color(hex: "663eae")
    static let mainViolet700 = Color(hex: "5f3ba4")
    static let mainViolet800 = Color(hex: "4c2f83")
    static let mainViolet900 = Color(hex: "392362")
    static let mainViolet1000 = Color(hex: "2c1b4c")
    
    // Text
    static let textTitle = Color(hex: "333333")
    static let textCaption1 = Color(hex: "868a92")
    static let textCaption2 = Color(hex: "b1b5bd")
    static let textBody = Color(hex: "353c49")
    
    // GrayScale
    static let gray100 = Color(hex: "f2f3f5")
    static let gray200 = Color(hex: "e5e5e5")
    static let gray300 = Color(hex: "e5e5e5")
    static let gray400 = Color(hex: "434343")
    static let gray600 = Color(hex: "262626")
    
    // Background
    static let bgLight = Color(hex: "ffffff")
    static let bgDark = Color(hex: "292929")
    
    // Warning
    static let warning = Color(hex: "ff4848")
}

// hex code to Color
public extension Color {

    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
