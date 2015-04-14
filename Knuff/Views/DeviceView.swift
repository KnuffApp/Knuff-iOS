//
//  DeviceView.swift
//  Knuff
//
//  Created by Simon Blommegard on 14/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class DeviceView: UIImageView {
  let screenshotView: UIImageView
  let screenshotClockView: UILabel
  
  convenience init() {
    let phone = (UIDevice.currentDevice().userInterfaceIdiom == .Phone)
    self.init(image: UIImage(named: phone ? "Phone" : "Pad"))
  }
  
  override init(image: UIImage!) {
    let phone = (UIDevice.currentDevice().userInterfaceIdiom == .Phone)

    screenshotView = UIImageView(image: UIImage(named: phone ? "Phone Push" : "Pad Push"))
    screenshotClockView = UILabel()
    super.init(image: image)
    
    screenshotClockView.font = UIFont(name: "HelveticaNeue-Light", size: 4)
    screenshotClockView.textColor = UIColor(white: 1, alpha: 0.6)
    screenshotClockView.text = "14:24"
    screenshotClockView.sizeToFit()
    
    addSubview(screenshotView)
//    screenshotView.addSubview(screenshotClockView)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()

    let phone = (UIDevice.currentDevice().userInterfaceIdiom == .Phone)
    
    screenshotView.frame.origin = CGPoint(
      x: phone ? 22:23,
      y: 7
    )
  }
}


