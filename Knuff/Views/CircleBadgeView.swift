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
    isOpaque = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return CGSize(width: 24, height: 24)
  }
  
  override func layoutSubviews() {}
  
  var imageCircleContent: UIImage?
  var drawCircleContent: ((CGRect) -> Void)?
  
  override func draw(_ rect: CGRect) {
    let circlePath = UIBezierPath(ovalIn: bounds.insetBy(dx: 0.5, dy: 0.5))
    UIColor.white.set()
    circlePath.stroke()
    
    if let contentImage = imageCircleContent {
      let point = CGPoint(
        x: round(bounds.midX - contentImage.size.width/2),
        y: round(bounds.midY - contentImage.size.height/2)
      )
      
      contentImage.draw(at: point)
    }
    else if let contentClosure = drawCircleContent {
      contentClosure(rect)
    }
  }
}
