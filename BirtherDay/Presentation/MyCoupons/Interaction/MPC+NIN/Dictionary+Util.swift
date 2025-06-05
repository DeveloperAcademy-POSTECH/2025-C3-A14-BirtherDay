//
//  Dictionary+Util.swift
//  BirtherDay
//
//  Created by Soop on 6/5/25.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    var jsonData: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
