//
//  Font+Extension.swift
//  BirtherDay
//
//  Created by Soop on 6/1/25.
//

// TODO: Line Height Percentage는 UIkit 활용해서 적용해야 함. 아직 미적용

import SwiftUI

extension Font {
    // Regular
    /// Regular 14/150
    static let r1: Font = .custom("Pretendard-Regular", size: 14)      // 150%
    
    /// Regular 18/150
    static let r2: Font = .custom("Pretendard-Regular", size: 18)      // 150%
    
    /// Regular 12/150
    static let r3: Font = .custom("Pretendard-Regular", size: 20)      // 150%
    
    /// Regular 12/150
    static let r4: Font = .custom("Pretendard-Regular", size: 12)      // 150%
    
    
    // Medium
    /// Medium 16/150
    static let m1: Font = .custom("Pretendard-Medium", size: 16)    // 150%
    
    /// Medium 18/150
    static let m2: Font = .custom("Pretendard-Medium", size: 18)    // 150%
    
    // Semibold
    /// SemiBold 16/150
    static let sb1: Font = .custom("Pretendard-Semibold", size: 16) // 150%
    
    /// SemiBold 18/150
    static let sb2: Font = .custom("Pretendard-Semibold", size: 18) // 150%
    
    /// SemiBold 20/150
    static let sb3: Font = .custom("Pretendard-Semibold", size: 20) // 150%
    
    /// SemiBold 22/150
    static let sb4: Font = .custom("Pretendard-Semibold", size: 22) // 150%
    
    /// SemiBold 24/150
    static let sb5: Font = .custom("Pretendard-Semibold", size: 24) // 130%
    
    
    // Bold
    /// Bold 14/150
    static let b1: Font = .custom("Pretendard-Bold", size: 14)      // 150%
    
    /// Bold 18/150
    static let b2: Font = .custom("Pretendard-Bold", size: 18)      // 150%
    
    /// Bold 24/130
    static let b3: Font = .custom("Pretendard-Bold", size: 24)      // 130%
}
