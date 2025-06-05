//
//  MCSessionState.swift
//  BirtherDay
//
//  Created by Soop on 6/5/25.
//

import SwiftUI
import MultipeerConnectivity

extension MCSessionState {
    var displayString: String {
        switch self {
        case .notConnected:
            return "Not Connected"
        case .connecting:
            return "Connecting..."
        case .connected:
            return "Connected"
        @unknown default:
            return "Unknown"
        }
    }
}
