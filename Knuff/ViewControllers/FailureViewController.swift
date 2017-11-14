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
  var settingsButton: Button?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel = UILabel()
    titleLabel!.text = "Couldn't get a device token."
    titleLabel!.font = UIFont(name: "OpenSans-Bold", size: 18)
    titleLabel!.textColor = UIColor(hex: 0xF7F9FC)
    titleLabel!.sizeToFit()
    view.addSubview(titleLabel!)
    
    pulseView = DevicePulseView(state: PulseViewState.failure)
    pulseView!.sizeToFit()
    view.addSubview(pulseView!)
    
    infoTitleLabel = UILabel()
    infoTitleLabel!.text = "Allow Knuff to send notifications to you."
    infoTitleLabel!.font = UIFont(name: "OpenSans", size: 12)
    infoTitleLabel!.textColor = UIColor(hex: 0xF7F9FC)
    infoTitleLabel!.sizeToFit()
    view.addSubview(infoTitleLabel!)
    
    infoLabel = UILabel()
    infoLabel!.text = "To receive push notifications from your computer you need to allow Knuff to receive them."
    infoLabel!.font = UIFont(name: "OpenSans-Light", size: 12)
    infoLabel!.textColor = UIColor(white: 1, alpha: 1)
    infoLabel!.textAlignment = NSTextAlignment.center
    infoLabel!.numberOfLines = 0
    infoLabel!.bounds.size = infoLabel!.sizeThatFits(CGSize(width: 300, height: CGFloat.greatestFiniteMagnitude))
    view.addSubview(infoLabel!)
    
    settingsButton = Button(type: .system)
    settingsButton!.setTitle("OPEN SETTINGS", for: .normal)
    settingsButton!.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 12)
    settingsButton!.setTitleColor(UIColor(hex: 0x6DB0F8), for: .normal)
    settingsButton!.addTarget(
      self,
      action: #selector(FailureViewController.settings),
      for: .touchUpInside
    )
    view.addSubview(settingsButton!)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    pulseView!.pulseView.startAnimations()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let compactWidth = (traitCollection.horizontalSizeClass == .compact)
    
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
    
    settingsButton!.sizeToFit()
    if (compactWidth) {
      settingsButton!.frame = CGRect(
        x: 0,
        y: view.bounds.height-settingsButton!.bounds.height-bottomLayoutGuide.length,
        width: view.bounds.width,
        height: settingsButton!.bounds.height
      )
    } else {
      settingsButton!.frame.origin = CGPoint(
        x: round((view.bounds.width/2) - (settingsButton!.bounds.width/2)),
        y: infoLabel!.frame.maxY + 40
      )
    }
  }
  
  @objc func settings() {
    if let url = URL(string:UIApplicationOpenSettingsURLString) {
      UIApplication.shared.openURL(url)
    }
  }
}
