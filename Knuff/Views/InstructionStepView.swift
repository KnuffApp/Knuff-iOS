//
//  InstructionStepView.swift
//  Knuff
//
//  Created by Simon Blommegard on 26/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Cartography

class InstructionStepView: UIView {

  let label: UILabel
  let badge: CircleBadgeView
  
  convenience init(title: String, badgeString: String?) {
    self.init(frame: CGRectZero)

    label.text = title

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
    
    addSubview(badge)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    layout(badge, label) { badge, label in
      badge.left == badge.superview!.left
      badge.top == badge.superview!.top
      badge.bottom == badge.superview!.bottom
      
      label.left == badge.right + 10
      label.centerY == label.superview!.centerY
      label.right == label.superview!.right
    }
  }
  
}
