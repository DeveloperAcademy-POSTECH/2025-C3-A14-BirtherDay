//
//  MultipeerManager.swift
//  BirtherDay
//
//  Created by Soop on 6/5/25.
//

import Foundation
import MultipeerConnectivity

@Observable
class MultipeerManager: NSObject {
 
    private var advertiser: MCNearbyServiceAdvertiser?
    private var browser: MCNearbyServiceBrowser?
    
    var mcSession: MCSession                    // 하나의 MCSession 안에서 여러 기기와 연결. 내가 ad일 때도 사용, brow일 때도 상대에게 공유
    
    private let serviceType = "birtherday" // same as that in info.plist
    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
    private let maxNumPeers: Int = 1
    
    var peerDataHandler: ((Data, MCPeerID) -> Void)?    // 다른 피어로부터 데이터를 받았을 때
    var peerConnectedHandler: ((MCPeerID) -> Void)?     // 다른 피어와 연결됐을 때
    var peerDisconnectedHandler: ((MCPeerID) -> Void)?  // 다른 피어와 연결 끊어졌을 때
    
    var connectedPeer: MCPeerID?
    var mpcSessionState: MCSessionState = .notConnected
    
    var myCoupon: RetrieveCouponResponse
    
    init(myCoupon: RetrieveCouponResponse) {
        // 1. myCoupon 초기화
        self.myCoupon = myCoupon
        
        // 2. myPeerID (이미 선언 시 초기화됨)
        
        // 3. advertiser 초기화
        self.advertiser = MCNearbyServiceAdvertiser(
            peer: myPeerID,
            discoveryInfo: ["couponId": myCoupon.couponId],
            serviceType: serviceType
        )
        
        // 4. browser 초기화
        self.browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        
        // 5. mcSession 초기화
        self.mcSession = MCSession(
            peer: myPeerID,
            securityIdentity: nil,
            encryptionPreference: .required
        )
        
        // 6. super.init() 호출
        super.init()
        
        // 7. delegate 설정
        mcSession.delegate = self
        advertiser?.delegate = self
        browser?.delegate = self
    }

    
    private func makeNewSession() -> MCSession {
        let session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }
    
    // Error
    enum MultipeerError: Error {
        case invitationFailed(String)
        case startBrowsingFailed(String)
        case startAdvertisingFailed(String)
        case sendMessageFailed(String)
        
        var message: String {
            switch self {
            case .invitationFailed(let text):
                text
            case .startBrowsingFailed(let text):
                text
            case .startAdvertisingFailed(let text):
                text
            case .sendMessageFailed(let text):
                text
            }
        }
    }
        
    struct Message {
        var isSent: Bool
        var data: Data
    }
    
    // 오류 메시지를 화면에 잠깐 보여주고 자동으로 사라지게 함
    var error: MultipeerError? = nil {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.error = nil
            })
        }
    }
    
    // MPC 실행
    func start() {
        print("MPC 실행")
        
        if advertiser == nil {
            print("start() - advertiser 재초기화")
            advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: ["couponId": myCoupon.couponId], serviceType: serviceType)
            advertiser?.delegate = self
        }
        
        advertiser?.startAdvertisingPeer()
        
        if browser == nil {
            print("start() - browser 재초기화")
            browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
            browser?.delegate = self
        }
        browser?.startBrowsingForPeers()
    }
    
    // MPC 중단
    func suspend() {
        print("MultiPeerManager - suspend()")
        
        advertiser?.stopAdvertisingPeer()
        browser?.stopBrowsingForPeers()
        advertiser = nil
        browser = nil
    }

    // MPC
    func invalidate() {
        print("MultipeerManager - invalidate()")
        suspend()
        mcSession.disconnect()
        mcSession.delegate = nil
        advertiser?.delegate = nil
        browser?.delegate = nil
        advertiser = nil
        browser = nil
    }

    
    /// peer의 연결에 성공했을 때 호출
    private func peerConnected(peerID: MCPeerID) {
        print("MPC - peerConnected")
        if let handler = peerConnectedHandler {
            DispatchQueue.main.async {
                handler(peerID)
                self.connectedPeer = peerID
                print("MPC: \(peerID) 실행")
            }
        }
        
        if mcSession.connectedPeers.count == maxNumPeers {
            self.suspend()
        }
    }
    
    /// peer의 연결이 끊어졌을 때 호출
    private func peerDisconnected(peerID: MCPeerID) {
        print("MPC - peerDisconnected")
        if let handler = peerDisconnectedHandler {
            DispatchQueue.main.async {
                handler(peerID)
                print("MPC: \(peerID) 연결 해제")
            }
        }
    }
    
    func sendDataToAllPeers(data: Data) {
        sendData(data: data, peers: mcSession.connectedPeers, mode: .reliable)
    }

    func sendData(data: Data, peers: [MCPeerID], mode: MCSessionSendDataMode) {
        do {
            // data 전송
            try mcSession.send(data, toPeers: peers, with: mode)
        } catch let error {
            NSLog("Error sending data: \(error)")
        }
    }
}

extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("상대 peerID: \(peerID) || 내 peerID: \(self.myPeerID)")
        guard peerID != myPeerID else { return }  // 자기 자신에 대한 초대 방지
        
        // 쿠폰 ID 일치 여부 확인 (상대 쿠폰 ID는 info에서 받아야 함)
        if let peerCouponId = info?["couponId"], peerCouponId == myCoupon.couponId {
            let context = ["couponId": myCoupon.couponId].jsonData
            browser.invitePeer(peerID, to: mcSession, withContext: context, timeout: 100)
        } else {
            // 쿠폰 ID 불일치 시 초대 보내지 않음
            self.mpcSessionState = .notConnected
            print("쿠폰 ID 불일치로 초대 미전송: \(info?["couponId"] ?? "nil")")
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }
}

extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
    // 내 기기가 서비스 중일 때, 근처 기기(MCPeer)로부터 세션에 연결하겠다는 요청이 들어왔을 때 호출
    // -> 내가 advertiser를 실행할 때, 다른 기기가 invitePeer()를 호출하면 이 메서드가 자동 실행
    // peerID: 연결을 요청한 상대방의 peer ID
    // context: 상대방이 초대에 포함시킨 부가 정보. ex. 사용자의 ID등 (신뢰할 수 없으므로 주의)
    // invitationHandler: 초대 수락/거절을 결정하는 콜백. true: 수락, false: 거절. 세션도 같이 넘겨야 함
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        print("초대 받음: \(peerID.displayName), with context: \(String(describing: context?.string))")
        
        guard let couponId = context?.asStringDictionary?["couponId"] else { return }
        print("상대 쿠폰: \(couponId) || 내 쿠폰: \(myCoupon.couponId)")
            
           if couponId == myCoupon.couponId && mcSession.connectedPeers.count < maxNumPeers {
                // ✅ 상대방이 나와 같은 쿠폰 ID를 가지고 있음
            print("✅ 상대방이 나와 같은 쿠폰 ID를 가지고 있음")
            
                invitationHandler(true, mcSession)
               
            } else {
                // ❌ 쿠폰 ID 불일치
                print("❌ 쿠폰 ID 불일치")
                invitationHandler(false, nil)
            }
        
    }
}

extension MultipeerManager: MCSessionDelegate {
    // 피어의 연결 상태가 바뀔 때 호출
    // 연결이 끊겼는지 확인
    // state에 따라 어떤 핸들러를 부를지 결정
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            self.mpcSessionState = .connected
            self.peerConnected(peerID: peerID)

        case .notConnected:
            self.mpcSessionState = .notConnected
            self.peerDisconnected(peerID: peerID)
        case .connecting:
            self.mpcSessionState = .connecting
            break
        @unknown default:   // 미래 확장성을 고려하여 추가
            fatalError("Unhandled MCSessionState")
        }
        
        print("MP Manager : \(state.displayString)")
    }
    
    // 상대 peer가 나한테 Data를 전송했을 때 호출
    // 텍스트, JSON, 커맨드 등의 메시지
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let handler = peerDataHandler {
            DispatchQueue.main.async {
                handler(data, peerID)
            }
        }
    }
    
    // 사용 안 함
    // 실시간 스트리밍 데이터 (오디오, 비디오 등)를 수신할 때 사용
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("receive stream.")
    }
    
    // 상대방이 파일 등을 전송하기 시작했을 때 호출
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("start receiving resource with progress: \(progress)")
    }
    
    // 리소스(파일 등)를 모두 수신했을 때 호출
    // localURL에 파일이 저장
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: (any Error)?) {
        print("finish receiving resource. url: \(String(describing: localURL)), error: \(String(describing: error))")
    }
}

