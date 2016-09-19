//
//  ServiceAdvertiser.swift
//  Knuff
//
//  Created by Simon Blommegard on 03/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class ServiceAdvertiser: NSObject {

  var serviceAdvertiser: MCNearbyServiceAdvertiser?
  var deviceTokenString: String?
  
  func setDeviceToken(_ deviceToken: Data?) {
    if let token = deviceToken {
      let tokenChars = (token as NSData).bytes.bindMemory(to: CChar.self, capacity: token.count)
      
      var tokenString = ""
      
      for i in 0 ..< token.count {
        tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
      }
      
      deviceTokenString = tokenString
    }
    else {
      deviceTokenString = nil
    }
    
    advertise()
  }
  
  func advertise() {
    if let advertiser = serviceAdvertiser {
      advertiser.stopAdvertisingPeer()
    }
    
    
    if let tokenString = deviceTokenString {
      let peerID = MCPeerID(displayName: UIDevice.current.name)
      
      serviceAdvertiser = MCNearbyServiceAdvertiser(
        peer: peerID,
        discoveryInfo: ["token": tokenString],
        serviceType: "knuff"
      )
      
      serviceAdvertiser?.delegate = self
      
      serviceAdvertiser?.startAdvertisingPeer();
    }
  }  
}

extension ServiceAdvertiser: MCNearbyServiceAdvertiserDelegate {
  
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
    
  }
  
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    invitationHandler(false, MCSession())
  }
}
