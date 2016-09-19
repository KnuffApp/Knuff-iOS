//
//  DevicePulseView.swift
//  Knuff
//
//  Created by Simon Blommegard on 31/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class DevicePulseView: UIView {
  
  let deviceImageView: UIImageView
  let pulseView: PulseView
  
  init(state: PulseViewState) {
    let phone = (UIDevice.current.userInterfaceIdiom == .phone)
    deviceImageView = UIImageView(image: UIImage(named: phone ? "Phone" : "Pad"))
    pulseView = PulseView(state: state)
    
    super.init(frame: CGRect.zero)
    
    addSubview(deviceImageView)
    
    pulseView.sizeToFit()
    addSubview(pulseView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return CGSize(
      width: deviceImageView.bounds.width + (((pulseView.bounds.width / 2) - 18) * 2),// (pulse - badge inset) * 2
      height: deviceImageView.bounds.height + (pulseView.bounds.width / 2)
    )
  }
  
  override func layoutSubviews() {
    deviceImageView.center = CGPoint(
      x: self.bounds.midX,
      y: self.bounds.height - deviceImageView.bounds.midY
    )

    pulseView.center = CGPoint(
      x: deviceImageView.frame.maxX  - 18,
      y: deviceImageView.frame.minY
    )
  }
}
