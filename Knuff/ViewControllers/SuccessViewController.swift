//
//  SuccessViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 30/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

  var titleLabel: UILabel?
  var pulseView: DevicePulseView?
  var checkView: InstructionStepView?
  var infoLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel = UILabel()
    titleLabel!.text = "Push galore!"
    titleLabel!.font = UIFont(name: "OpenSans-Bold", size: 18)
    titleLabel!.textColor = UIColor(hex: 0xF7F9FC)
    titleLabel!.sizeToFit()
    view.addSubview(titleLabel!)
    
    pulseView = DevicePulseView(state: PulseViewState.Success)
    pulseView!.sizeToFit()
    view.addSubview(pulseView!)
    
    checkView = InstructionStepView(title: "You are broadcasting your device", badgeString: nil)
    checkView!.badge.imageCircleContent = UIImage(named: "Check")
    checkView!.sizeToFit()
    view.addSubview(checkView!)
    
    infoLabel = UILabel()
    let deviceName = UIDevice.currentDevice().name
    infoLabel!.text = "To recieve push notifications from your computer just select \"\(deviceName)\" in the device list and tap the home button."
    infoLabel!.font = UIFont(name: "OpenSans-Light", size: 12)
    infoLabel!.textColor = UIColor(white: 1, alpha: 1)
    infoLabel!.textAlignment = .Center
    infoLabel!.numberOfLines = 0
    infoLabel!.bounds.size = infoLabel!.sizeThatFits(CGSize(width: 300, height: CGFloat.max))
    view.addSubview(infoLabel!)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    pulseView!.pulseView.startAnimations()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    titleLabel!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (titleLabel!.bounds.width/2)),
      y: topLayoutGuide.length + 50
    )
  
    checkView!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (checkView!.bounds.width/2)),
      y: round((view.bounds.height - checkView!.bounds.height) * 0.6)
    )
    
    let height = checkView!.frame.minY - titleLabel!.frame.maxY

    pulseView!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (pulseView!.bounds.width/2)),
      y: titleLabel!.frame.maxY + round(height/2 - (pulseView!.bounds.height/2))
    )
    
    infoLabel!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (infoLabel!.bounds.width/2)),
      y: checkView!.frame.maxY + 20
    )
  }
}
