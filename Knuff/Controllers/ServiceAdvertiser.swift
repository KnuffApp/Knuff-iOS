//
//  ServiceAdvertiser.swift
//  Knuff
//
//  Created by Simon Blommegard on 03/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class ServiceAdvertiser: NSObject, MCNearbyServiceAdvertiserDelegate{

  var serviceAdvertiser: MCNearbyServiceAdvertiser?
  var deviceTokenString: String?
  
  func setDeviceToken(deviceToken: NSData?) {
    if let token = deviceToken {
      let tokenChars = UnsafePointer<CChar>(token.bytes)
      
      var tokenString = ""
      
      for var i = 0; i < token.length; i++ {
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
      let peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
      
      serviceAdvertiser = MCNearbyServiceAdvertiser(
        peer: peerID,
        discoveryInfo: ["token": tokenString],
        serviceType: "knuff"
      )
      
      serviceAdvertiser?.delegate = self
      
      serviceAdvertiser?.startAdvertisingPeer();
    }
  }
  
  // MARK: - MCNearbyServiceAdvertiserDelegate
  
  func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {}
  
  func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: ((Bool, MCSession) -> Void)) {
    invitationHandler(false, MCSession())
  }
}
