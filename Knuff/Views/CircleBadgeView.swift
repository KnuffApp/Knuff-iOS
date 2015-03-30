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
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSizeMake(24, 24)
  }
  
  override func intrinsicContentSize() -> CGSize {
    return sizeThatFits(bounds.size);
  }
  
  override func layoutSubviews() {}
  
  var drawCircleContent: ((CGRect)->Void)?
  
  override func drawRect(rect: CGRect) {
    let circlePath = UIBezierPath(ovalInRect: bounds.rectByInsetting(dx: 1, dy: 1))
    UIColor.whiteColor().set()
    circlePath.stroke()
    
    if let contentClosure = drawCircleContent {
      contentClosure(rect)
    }
  }
}