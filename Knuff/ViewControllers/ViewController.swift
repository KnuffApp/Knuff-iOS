//
//  ViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 17/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import Cartography

class ViewController: UIViewController, MCNearbyServiceAdvertiserDelegate {
  var serviceAdvertiser: MCNearbyServiceAdvertiser?
  var infoView: IntoView?
  var infoCloseButton: InfoCloseButton?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor(hex: 0x1F3141, alpha: 1)
    
    infoView = IntoView(frame: CGRectZero)
    view.addSubview(infoView!)
    
    infoCloseButton = InfoCloseButton(frame: CGRectZero)
    view.addSubview(infoCloseButton!)
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    
    layout(infoView!) { infoView in
      infoView.center == infoView.superview!.center
      return
    }
    
    layout(infoCloseButton!) { infoCloseButton in
      infoCloseButton.top == infoCloseButton.superview!.top + self.topLayoutGuide.length + 10;
      infoCloseButton.right == infoCloseButton.superview!.right - 10;
    }
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  var deviceTokenString: String?
  
  func setDeviceToken(deviceToken: NSData) {
    let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
    
    var tokenString = ""
    
    for var i = 0; i < deviceToken.length; i++ {
      tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
    }
    
    deviceTokenString = tokenString
    
    advertise()
  }
  
  func advertise() {
    if let tokenString = deviceTokenString {
      let peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
      
      serviceAdvertiser = MCNearbyServiceAdvertiser(
        peer: peerID,
        discoveryInfo: ["token": tokenString, "type": "iOS"],
        serviceType: "apns-pusher"
      )
      
      serviceAdvertiser?.delegate = self

      serviceAdvertiser?.startAdvertisingPeer();
    }
  }

// MARK: - MCNearbyServiceAdvertiserDelegate
  
  func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
    
  }
  
  func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
    invitationHandler(false, nil)
  }
  
}
