//
//  InstructionsView.swift
//  Knuff
//
//  Created by Simon Blommegard on 27/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class InstructionsView: UIView {
  let steps1View: InstructionStepView
  let steps2View: InstructionStepView
  let steps3View: InstructionStepView
  
  override init(frame: CGRect) {
    steps1View = InstructionStepView(
      title: "Download the OSX Knuff composer app.",
      badgeString: "1"
    )
    steps2View = InstructionStepView(
      title: "Accept all notifications from this app.",
      badgeString: "2"
    )
    steps3View = InstructionStepView(
      title: "Link up both apps via WIFI and Push!",
      badgeString: "3"
    )
    
    super.init(frame: frame)
    
    steps1View.sizeToFit()
    addSubview(steps1View)

    steps2View.sizeToFit()
    addSubview(steps2View)
    
    steps3View.sizeToFit()
    addSubview(steps3View)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    return CGSize(
      width: max(steps1View.bounds.width, steps1View.bounds.width, steps1View.bounds.width),
      height: steps1View.bounds.height + 20 + steps1View.bounds.height + 20 + steps1View.bounds.height
    )
  }
  
  override func layoutSubviews() {
    steps2View.frame.origin = CGPoint(
      x: 0,
      y: steps1View.frame.maxY + 20
    )
    steps3View.frame.origin = CGPoint(
      x: 0,
      y: steps2View.frame.maxY + 20
    )
  }
}
