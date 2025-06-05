//
//  String+Util.swift
//  BirtherDay
//
//  Created by Soop on 6/5/25.
//

import SwiftUI

extension String {

    var data: Data? {
        self.data(using: .utf8)
    }
}
