//
//  InstructionStepView.swift
//  Knuff
//
//  Created by Simon Blommegard on 26/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class InstructionStepView: UIView {

  let label: UILabel
  let badge: CircleBadgeView
  
  convenience init(title: String, badgeString: String?) {
    self.init(frame: CGRect.zero)

    label.text = title
    label.sizeToFit()

    if let string = badgeString {
      badge.drawCircleContent = {(rect:CGRect) in
        let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = .center
        
        let attributedString = NSAttributedString(
          string: string,
          attributes: [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.paragraphStyle: style,
            NSAttributedStringKey.font: UIFont(name: "OpenSans", size: 12)!,
          ]
        )
        
        let size = attributedString.size()
        
        attributedString.draw(in: rect.insetBy(
          dx: 0,
          dy: floor(rect.height-size.height)/2)
        )
      }
    }
  }
  
  override init(frame: CGRect) {
    label = UILabel()
    badge = CircleBadgeView(frame: CGRect.zero)
    
    super.init(frame: frame)
    
    label.font = UIFont(name: "OpenSans", size: 12)
    label.textColor = UIColor(hex:0xF7F9FC)
    addSubview(label)

    badge.sizeToFit()
    addSubview(badge)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return CGSize(
      width: badge.bounds.width + 10 + label.bounds.width,
      height: badge.bounds.height
    )
  }
  
  override func layoutSubviews() {
    label.frame.origin = CGPoint(
      x: badge.frame.maxX + 10,
      y: round((bounds.height/2) - (label.bounds.height/2))
    )
  }
}
