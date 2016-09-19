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
    isOpaque = false
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    let gradient = CGGradient(
      colorsSpace: CGColorSpaceCreateDeviceRGB(),
      colors: [UIColor(hex: 0x1F3141).cgColor, UIColor(hex: 0x1F3141, alpha: 0).cgColor] as CFArray,
      locations: [0, 1]
    )
    
    guard let context = UIGraphicsGetCurrentContext(), let g = gradient else { return }
    
    context.drawLinearGradient(g,
      start: CGPoint(x: 0, y: 0),
      end: CGPoint(x: 0, y: bounds.height),
      options: []
    )
  }
}
