//
//  FailureViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 01/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class FailureViewController: UIViewController {
  
  var titleLabel: UILabel?
  var pulseView: DevicePulseView?
  var infoTitleLabel: UILabel?
  var infoLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel = UILabel()
    titleLabel!.text = "Couldn't get a device token."
    titleLabel!.font = UIFont(name: "OpenSans-Bold", size: 18)
    titleLabel!.textColor = UIColor(hex: 0xF7F9FC)
    titleLabel!.sizeToFit()
    view.addSubview(titleLabel!)
    
    pulseView = DevicePulseView(state: PulseViewState.Failure)
    pulseView!.sizeToFit()
    view.addSubview(pulseView!)
    
    infoTitleLabel = UILabel()
    infoTitleLabel!.text = "Allow Knuff to send notifications to you."
    infoTitleLabel!.font = UIFont(name: "OpenSans", size: 12)
    infoTitleLabel!.textColor = UIColor(hex: 0xF7F9FC)
    infoTitleLabel!.sizeToFit()
    view.addSubview(infoTitleLabel!)
    
    infoLabel = UILabel()
    infoLabel!.text = "To receive push notifications from your computer you need to allow Knuff to receive them. Allow notifications:\n\nSettings → Notifications → Knuff"
    infoLabel!.font = UIFont(name: "OpenSans-Light", size: 12)
    infoLabel!.textColor = UIColor(white: 1, alpha: 1)
    infoLabel!.textAlignment = NSTextAlignment.Center
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
    
    infoTitleLabel!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (infoTitleLabel!.bounds.width/2)),
      y: round((view.bounds.height - infoTitleLabel!.bounds.height) * 0.6)
    )
    
    let height = infoTitleLabel!.frame.minY - titleLabel!.frame.maxY
    
    pulseView!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (pulseView!.bounds.width/2)),
      y: titleLabel!.frame.maxY + round(height/2 - (pulseView!.bounds.height/2))
    )
    
    infoLabel!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (infoLabel!.bounds.width/2)),
      y: infoTitleLabel!.frame.maxY + 20
    )
  }
}
