//
//  CouponDetailViewModel.swift
//  BirtherDay
//
//  Created by Soop on 5/30/25.
//

import Foundation
import SwiftUI
import MultipeerConnectivity
import NearbyInteraction

enum DistanceDirectionState {
    case closeUpInFOV, notCloseUpInFOV, outOfFOV, unknown
}

@Observable
class CouponDetailViewModel: NSObject {

    var selectedCoupon: RetrieveCouponResponse = .stub01                 // 사용자가 고른 coupon
    var isConnectWithPeer: Bool = false         // peer와 연결되어있는지 여부
    var connectedPeer: MCPeerID?                // 연결된 Peer
    var isCompleted: Bool = false               // 쿠폰 사용 완료 여부
    
    var mpc: MultipeerManager?                  // MPC Manager
    
    var niSession: NISession?                   // NI 통신시 사용되는 Session
    var peerDiscoveryToken: NIDiscoveryToken?   // peer의 discoveryToken
    var sharedTokenWithPeer = false             // peer와 discoveryToken을 교환했는지 여부
    var currentDistanceDirectionState: DistanceDirectionState = .unknown
    
    var distance: Float?                        // peer간의 거리 (0.00m)
    let nearbyDistanceThreshold: Float = 0.5
    
    init(selectedCoupon: RetrieveCouponResponse) {
        self.selectedCoupon = selectedCoupon
    }
    
    deinit {
        print("deinit called")
    }
    
    func startupMPC() {
        print("CouponViewModel - startupMPC()")
        
        if mpc != nil {
            mpc?.invalidate()
        }
        
        let newMPC = MultipeerManager(myCoupon: selectedCoupon)
        newMPC.peerConnectedHandler = connectedToPeer
        newMPC.peerDataHandler = dataReceivedHandler
        newMPC.peerDisconnectedHandler = disconnectedFromPeer
        newMPC.start()
        self.mpc = newMPC
    }
    
    func stopMPC() {
        mpc?.invalidate()
        mpc = nil  // 반드시 nil 할당으로 인스턴스 제거
        isConnectWithPeer = false
        connectedPeer = nil
    }
    
    func startNI() {
        print("CouponViewModel - startupMPC()")
        
        // NISession 생성
        niSession = NISession()
        
        // delegate 설정
        niSession?.delegate = self
        
        sharedTokenWithPeer = false
        
        if connectedPeer != nil && mpc != nil {
            if let myToken = niSession?.discoveryToken {
                print("myToken: \(myToken)")
                // 화면 업데이트 (찾는 중)
                if !sharedTokenWithPeer {
                    shareMyDiscoveryToken(token: myToken)
                }
                guard let peerToken = peerDiscoveryToken else {
                    print("peerToken 없음")
                    return
                }
                print("run config")
                let config = NINearbyPeerConfiguration(peerToken: peerToken)
                niSession?.run(config)
            } else {
                // TODO: Error - (Unable to get self discovery token)
                print("")
            }
        } else {
            print("Discovering Peer ...")
            startupMPC()
        }
    }
    
    /// NI 종료
    func stopNI() {
        self.niSession?.pause()
        self.niSession?.invalidate()
    }
    
    /// MPC 연결이 완료되었을 때 호출
    func connectedToPeer(peer: MCPeerID) {
        print("👻 MPC Connected")
        
        
        if connectedPeer != nil {
            return
        }
        
        connectedPeer = peer
        
        // TODO: - View에 값 변경이 감지가 되지 않는 버그 수정
        isConnectWithPeer = true
        
        print("💋 isConnectWithPeer: \(isConnectWithPeer)")
        
        stopMPC();
    }

    /// MPC 연결이 끊겼을 때 실행
    func disconnectedFromPeer(peer: MCPeerID) {
        
        print("🎃 MPC Disconnected")
        if connectedPeer == peer {
            connectedPeer = nil         // 연결된 Peer id 제거
            isConnectWithPeer = false   // TODO: - 상태 변경 -> enum으로 관리하기
        }
        
        print("💋 isConnectWithPeer: \(isConnectWithPeer)")
    }

    /// 상대방이 보내온 NIDiscoveryToken을 수신했을 때 실행
    func dataReceivedHandler(data: Data, peer: MCPeerID) {
        // discoveryToken을 서로 공유했다면, ni 시작
        print("상대방이 보내온 NIDiscoveryToken을 수신했을 때 실행")
        // 1. peerToken 저장
        guard let discoveryToken = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) else {
            fatalError("Unexpectedly failed to decode discovery token.")
        }
        peerDidShareDiscoveryToken(peer: peer, token: discoveryToken)
    }
    
    /// NIN 통신을 위한 discoveryToken 공유
    func shareMyDiscoveryToken(token: NIDiscoveryToken) {
        print("shareMyDiscoveryToken()")
        guard let encodedData = try?  NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true) else {
            fatalError("Unexpectedly failed to encode discovery token.")
        }
        mpc?.sendDataToAllPeers(data: encodedData)
        sharedTokenWithPeer = true
    }
    
    /// discoveryToken 공유, config 파일 제작, NIN 통신 시작
    func peerDidShareDiscoveryToken(peer: MCPeerID, token: NIDiscoveryToken) {
        print("peerDidShareDiscoveryToken(\(token)")
        if connectedPeer != peer {
            #if DEBUG
            fatalError("Received token from unexpected peer.")
            #endif
        }
        // Create a configuration.
        peerDiscoveryToken = token

        let config = NINearbyPeerConfiguration(peerToken: token)

        // Run the session.
        print("run the session")
        niSession?.run(config)
    }
    
    func isNearby(_ distance: Float) -> Bool {
        return distance < nearbyDistanceThreshold
    }
}

extension CouponDetailViewModel: NISessionDelegate {
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        guard let peerToken = peerDiscoveryToken else {
            fatalError("don't have peer token")
        }
        
        /// discoveryToken을 사용해서 peer 확인
        let peerObj = nearbyObjects.first { (obj) -> Bool in
            return obj.discoveryToken == peerToken
        }

        guard let nearbyObjectUpdate = peerObj else {
            return
        }
        
        self.distance = nearbyObjectUpdate.distance
    }

    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
        print("NISession didRemove")
        guard let peerToken = peerDiscoveryToken else {
            fatalError("don't have peer token")
        }
        // Find the right peer.
        let peerObj = nearbyObjects.first { (obj) -> Bool in
            return obj.discoveryToken == peerToken
        }

        if peerObj == nil {
            return
        }

        currentDistanceDirectionState = .unknown
        
        // 피어 연결해제 원인
        switch reason {
        case .peerEnded:
            // The peer token is no longer valid.
            peerDiscoveryToken = nil
 
            session.invalidate()
            
            // Restart the sequence to see if the peer comes back.
            startNI()

        case .timeout:
            
            // The peer timed out, but the session is valid.
            // If the configuration is valid, run the session again.
            if let config = session.configuration {
                session.run(config)
            }
        default:
            fatalError("Unknown and unhandled NINearbyObject.RemovalReason")
        }
    }
    
    func session(_ session: NISession, didInvalidateWith error: Error) {
        currentDistanceDirectionState = .unknown
        
        // If the app lacks user approval for Nearby Interaction, present
        // an option to go to Settings where the user can update the access.
        if case NIError.userDidNotAllow = error {
            if #available(iOS 15.0, *) {

                let accessAlert = UIAlertController(title: "Access Required",
                                                    message: """
                                                    NIPeekaboo requires access to Nearby Interactions for this sample app.
                                                    Use this string to explain to users which functionality will be enabled if they change
                                                    Nearby Interactions access in Settings.
                                                    """,
                                                    preferredStyle: .alert)
                accessAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                accessAlert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: {_ in
                    // Send the user to the app's Settings to update Nearby Interactions access.
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                    }
                }))
                
            } else {

            }
            
            return
        }
    }
}

