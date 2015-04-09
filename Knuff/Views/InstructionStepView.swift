//
//  InstructionStepView.swift
//  Knuff
//
//  Created by Simon Blommegard on 26/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Snap

class InstructionStepView: UIView {

  let label: UILabel
  let badge: CircleBadgeView
  
  convenience init(title: String, badgeString: String?) {
    self.init(frame: CGRectZero)

    label.text = title
    label.sizeToFit()

    if let string = badgeString {
      badge.drawCircleContent = {(rect:CGRect) in
        let style = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        style.alignment = NSTextAlignment.Center
        
        let attributedString = NSAttributedString(
          string: string,
          attributes: [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSParagraphStyleAttributeName: style,
            NSFontAttributeName: UIFont(name: "OpenSans", size: 12)!,
          ]
        )
        
        let size = attributedString.size()
        
        attributedString.drawInRect(rect.rectByInsetting(
          dx: 0,
          dy: floor(rect.height-size.height)/2)
        )
      }
    }
  }
  
  override init(frame: CGRect) {
    label = UILabel()
    badge = CircleBadgeView(frame: CGRectZero)
    
    super.init(frame: frame)
    
    label.font = UIFont(name: "OpenSans", size: 12)
    label.textColor = UIColor(hex:0xF7F9FC , alpha: 1)
    addSubview(label)

    badge.sizeToFit()
    addSubview(badge)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSize(
      width: 24 + label.bounds.width,
      height: 24
    )
  }
  
  override func layoutSubviews() {
    label.frame.origin = CGPoint(
      x: badge.frame.maxX + 10,
      y: round((bounds.height/2) - (label.bounds.height/2))
    )
  }
}
