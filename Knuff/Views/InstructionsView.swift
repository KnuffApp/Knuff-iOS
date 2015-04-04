//
//  InstructionsView.swift
//  Knuff
//
//  Created by Simon Blommegard on 27/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Snap

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
    
    steps1View.snp_remakeConstraints({ make in
      make.top.left.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    steps2View.snp_remakeConstraints({ make in
      make.left.equalTo(self)
      make.top.equalTo(self.steps1View.snp_bottom).offset(20)
      make.right.lessThanOrEqualTo(self)
    })
    
    steps3View.snp_remakeConstraints({ make in
      make.left.bottom.equalTo(self)
      make.top.equalTo(self.steps2View.snp_bottom).offset(20)
      make.right.lessThanOrEqualTo(self)
    })
  }
}
