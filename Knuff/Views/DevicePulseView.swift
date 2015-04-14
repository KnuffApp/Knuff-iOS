//
//  DevicePulseView.swift
//  Knuff
//
//  Created by Simon Blommegard on 31/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import pop

class DevicePulseView: UIView {
  
  let deviceImageView: UIImageView
  let pulseView: PulseView
  
  init(state: PulseViewState) {
    let phone = (UIDevice.currentDevice().userInterfaceIdiom == .Phone)
    deviceImageView = UIImageView(image: UIImage(named: phone ? "Phone" : "Pad"))
    pulseView = PulseView(state: state)
    
    super.init(frame: CGRectZero)
    
    addSubview(deviceImageView)
    
    pulseView.sizeToFit()
    addSubview(pulseView)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSizeMake(
      deviceImageView.bounds.width + (((pulseView.bounds.width / 2) - 18) * 2),// (pulse - badge inset) * 2
      deviceImageView.bounds.height + (pulseView.bounds.width / 2)
    )
  }
  
  override func layoutSubviews() {
    deviceImageView.center = CGPointMake(
      self.bounds.midX,
      self.bounds.height - deviceImageView.bounds.midY
    )

    pulseView.center = CGPointMake(
      deviceImageView.frame.maxX  - 18,
      deviceImageView.frame.minY
    )
  }
}