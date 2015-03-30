//
//  InstructionsView.swift
//  Knuff
//
//  Created by Simon Blommegard on 27/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Cartography

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
    
    addSubview(steps1View)
    addSubview(steps2View)
    addSubview(steps3View)
    
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    layout(steps1View, steps2View, steps3View) { steps1View, steps2View, steps3View in
      steps1View.top == steps1View.superview!.top
      steps1View.left == steps1View.superview!.left
      steps1View.superview!.width >= steps1View.width
      
      steps2View.top == steps1View.bottom + 20
      steps2View.left == steps2View.superview!.left
      steps2View.superview!.width >= steps2View.width
      
      steps3View.top == steps2View.bottom + 20
      steps3View.left == steps3View.superview!.left
      steps3View.superview!.width >= steps3View.width
      steps3View.bottom == steps3View.superview!.bottom
    }
  }
}
