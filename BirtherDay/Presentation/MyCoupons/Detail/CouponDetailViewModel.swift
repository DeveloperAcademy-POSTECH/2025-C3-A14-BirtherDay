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
    var currentDistance: Float?                 // peer간의 거리 (0.00m)
    
    var mpc: MultipeerManager?                  // MPC Manager
    
    var niSession: NISession?                   // NI 통신시 사용되는 Session
    var peerDiscoveryToken: NIDiscoveryToken?   // peer의 discoveryToken
    var sharedTokenWithPeer = false             // peer와 discoveryToken을 교환했는지 여부
    var currentDistanceDirectionState: DistanceDirectionState = .unknown
    
    var distance: Float?
    
    init(selectedCoupon: RetrieveCouponResponse) {
        self.selectedCoupon = selectedCoupon
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
    

    // TODO: Move to MPC Manager
    // MPC 연결이 완료되었을 때 호출
    func connectedToPeer(peer: MCPeerID) {
        print("MPC Connected")
        
        
        if connectedPeer != nil {
            fatalError("Already connected to a peer.")
        }
        
        connectedPeer = peer
        isConnectWithPeer = true
    }

    // MPC 연결이 끊겼을 때 실행됨
    func disconnectedFromPeer(peer: MCPeerID) {
        
        print("MPC Disconnected")
        if connectedPeer == peer {
            connectedPeer = nil         // 연결된 Peer id 제거
            isConnectWithPeer = false   // TODO: - 상태 변경 -> enum으로 관리하기
            
        }
        
        // ni 연결 끊기
    }

    // 상대방이 보내온 NIDiscoveryToken을 수신했을 때 실행
    func dataReceivedHandler(data: Data, peer: MCPeerID) {
        // discoveryToken을 서로 공유했다면, ni 시작
        print("상대방이 보내온 NIDiscoveryToken을 수신했을 때 실행")
        // 1. peerToken 저장
        guard let discoveryToken = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) else {
            fatalError("Unexpectedly failed to decode discovery token.")
        }
        peerDidShareDiscoveryToken(peer: peer, token: discoveryToken)
        // 2. runConfiguration 실행
        
    }
    
    // NI
    func shareMyDiscoveryToken(token: NIDiscoveryToken) {
        print("shareMyDiscoveryToken()")
        guard let encodedData = try?  NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true) else {
            fatalError("Unexpectedly failed to encode discovery token.")
        }
        mpc?.sendDataToAllPeers(data: encodedData)
        sharedTokenWithPeer = true
    }
    
    func peerDidShareDiscoveryToken(peer: MCPeerID, token: NIDiscoveryToken) {
        print("peerDidShareDiscoveryToken(\(token)")
        if connectedPeer != peer {
            fatalError("Received token from unexpected peer.")
        }
        // Create a configuration.
        peerDiscoveryToken = token

        let config = NINearbyPeerConfiguration(peerToken: token)

        // Run the session.
        print("run the session")
        niSession?.run(config)
    }
}

extension CouponDetailViewModel: NISessionDelegate {
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
//        print("NISession didUpdate")
        guard let peerToken = peerDiscoveryToken else {
            fatalError("don't have peer token")
        }

        // Find the right peer.
        let peerObj = nearbyObjects.first { (obj) -> Bool in
            return obj.discoveryToken == peerToken
        }

        guard let nearbyObjectUpdate = peerObj else {
            return
        }
        
        
        self.distance = nearbyObjectUpdate.distance
//        print("\(String(describing: distance))")
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
            
            // The peer stopped communicating, so invalidate the session because
            // it's finished.
            session.invalidate()
            
            // Restart the sequence to see if the peer comes back.
            startNI()
            
            // Update the app's display.
//            updateInformationLabel(description: "Peer Ended")
        case .timeout:
            
            // The peer timed out, but the session is valid.
            // If the configuration is valid, run the session again.
            if let config = session.configuration {
                session.run(config)
            }
//            updateInformationLabel(description: "Peer Timeout")
        default:
            fatalError("Unknown and unhandled NINearbyObject.RemovalReason")
        }
    }
//
    
    
    func session(_ session: NISession, didInvalidateWith error: Error) {
        currentDistanceDirectionState = .unknown
        
        // If the app lacks user approval for Nearby Interaction, present
        // an option to go to Settings where the user can update the access.
        if case NIError.userDidNotAllow = error {
            if #available(iOS 15.0, *) {
                // In iOS 15.0, Settings persists Nearby Interaction access.
                //                updateInformationLabel(description: "Nearby Interactions access required. You can change access for NIPeekaboo in Settings.")
                // Create an alert that directs the user to Settings.
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
                
                // Display the alert.
                //                present(accessAlert, animated: true, completion: nil)
            } else {
                // Before iOS 15.0, ask the user to restart the app so the
                // framework can ask for Nearby Interaction access again.
                //                updateInformationLabel(description: "Nearby Interactions access required. Restart NIPeekaboo to allow access.")
            }
            
            return
        }
    }
}

