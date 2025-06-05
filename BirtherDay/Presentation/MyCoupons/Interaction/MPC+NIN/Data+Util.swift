//
//  Data+Util.swift
//  BirtherDay
//
//  Created by Soop on 6/5/25.
//

import SwiftUI

extension Data {
    // 통신으로 주고받는 Data를 사람이 읽을 수 있는 형태로 쉽게 다룸
    // MPC는 메시지를 Data 타입으로 주고 받는다.
    // 대부분 우리가 보내고자 하는 건 텍스트(String) 또는 인코딩된 JSON 파일
    ///
    /// func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    /// print("받은 메시지: \(data.string ?? "읽을 수 없음")")
    /// }
    ///

    var string: String? {
        String(data: self, encoding: .utf8)
    }
}


extension Data {
    var asStringDictionary: [String: String]? {
        try? JSONSerialization.jsonObject(with: self, options: []) as? [String: String]
    }
}
