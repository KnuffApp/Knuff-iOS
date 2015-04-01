//
//  SuccessView.swift
//  Knuff
//
//  Created by Simon Blommegard on 01/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Cartography

class SuccessView: UIView {
  
  let titleLabel: UILabel
  let pulseView: DevicePulseView
  let checkView: InstructionStepView
  let infoLabel: UILabel
  
  override init(frame: CGRect) {
    titleLabel = UILabel()
    pulseView = DevicePulseView(frame: CGRectZero)
    checkView = InstructionStepView(title: "You are broadcasting your device", badgeString: nil)
    infoLabel = UILabel()
    
    super.init(frame: frame)
    
    titleLabel.text = "Push galore!"
    titleLabel.font = UIFont(name: "OpenSans-Bold", size: 18)
    titleLabel.textColor = UIColor(hex: 0xF7F9FC, alpha: 1)
    addSubview(titleLabel)
    
    addSubview(pulseView)
    
    checkView.badge.imageCircleContent = UIImage(named: "Check")
    addSubview(checkView)
    
    
    let deviceName = UIDevice.currentDevice().name
    infoLabel.text = "To recieve push notifications from your computer just select \"\(deviceName)\" in the device list and tap the home button."
    infoLabel.font = UIFont(name: "OpenSans-Light", size: 12)
    infoLabel.textColor = UIColor(white: 1, alpha: 1)
    infoLabel.textAlignment = NSTextAlignment.Center
    infoLabel.numberOfLines = 0
    infoLabel.preferredMaxLayoutWidth = 300
    addSubview(infoLabel)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    layout(titleLabel) { titleLabel in
      titleLabel.top == titleLabel.superview!.top
      titleLabel.centerX == titleLabel.superview!.centerX
      titleLabel.superview!.width >= titleLabel.width
    }
    
    layout(titleLabel, pulseView) { titleLabel, pulseView in
      pulseView.centerX == pulseView.superview!.centerX
      pulseView.top == titleLabel.bottom + 20
      pulseView.superview!.width >= pulseView.width
    }
    
    layout(pulseView, checkView) { pulseView, checkView in
      checkView.centerX == checkView.superview!.centerX
      checkView.top == pulseView.bottom + 20
      checkView.superview!.width >= checkView.width
    }
    
    layout(checkView, infoLabel) { checkView, infoLabel in
      infoLabel.centerX == infoLabel.superview!.centerX
      infoLabel.top == checkView.bottom + 20
      infoLabel.superview!.width >= infoLabel.width
      
      infoLabel.bottom == infoLabel.superview!.bottom
    }
  }
}
