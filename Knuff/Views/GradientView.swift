//
//  GradientView.swift
//  Knuff
//
//  Created by Simon Blommegard on 11/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class GradientView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    opaque = false
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func drawRect(rect: CGRect) {
    let gradient = CGGradientCreateWithColors(
      CGColorSpaceCreateDeviceRGB(),
      [UIColor(hex: 0x1F3141).CGColor, UIColor(hex: 0x1F3141, alpha: 0).CGColor],
      [0, 1]
    )
    
    CGContextDrawLinearGradient(
      UIGraphicsGetCurrentContext(),
      gradient,
      CGPoint(x: 0, y: 0),
      CGPoint(x: 0, y: bounds.height),
      0
    )
  }
}