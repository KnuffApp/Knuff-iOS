//
//  CircleView.swift
//  Knuff
//
//  Created by Simon Blommegard on 30/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class CircleView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    isOpaque = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    let circlePath = UIBezierPath(ovalIn: bounds.insetBy(dx: 1, dy: 1))
    UIColor(hex: 0x6DB0F8).set()
    circlePath.stroke()
  }
}
