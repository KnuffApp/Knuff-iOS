//
//  CircleBadgeView.swift
//  Knuff
//
//  Created by Simon Blommegard on 26/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class CircleBadgeView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    opaque = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSizeMake(24, 24)
  }
  
  override func layoutSubviews() {}
  
  var imageCircleContent: UIImage?
  var drawCircleContent: (CGRect -> Void)?
  
  override func drawRect(rect: CGRect) {
    let circlePath = UIBezierPath(ovalInRect: bounds.insetBy(dx: 0.5, dy: 0.5))
    UIColor.whiteColor().set()
    circlePath.stroke()
    
    if let contentImage = imageCircleContent {
      let point = CGPointMake(
        round(bounds.midX - contentImage.size.width/2),
        round(bounds.midY - contentImage.size.height/2)
      )
      
      contentImage.drawAtPoint(point)
    }
    else if let contentClosure = drawCircleContent {
      contentClosure(rect)
    }
  }
}