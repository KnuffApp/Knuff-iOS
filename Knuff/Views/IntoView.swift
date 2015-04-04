//
//  IntoView.swift
//  Knuff
//
//  Created by Simon Blommegard on 26/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Snap

class IntoView: UIView {

  let titleLabel, subtitleLabel: UILabel
  let illustrationView: PushIllustrationView
  let instructionsView: InstructionsView
  
  override init(frame: CGRect) {
    titleLabel = UILabel()
    subtitleLabel = UILabel()
    illustrationView = PushIllustrationView(frame: CGRectZero)
    instructionsView = InstructionsView(frame: CGRectZero)
    
    super.init(frame: frame)
    
    titleLabel.text = "Let’s get started!"
    titleLabel.font = UIFont(name: "OpenSans-Bold", size: 18)
    titleLabel.textColor = UIColor(hex: 0xF7F9FC, alpha: 1)
    addSubview(titleLabel)
    
    subtitleLabel.text = "Your first push is just a few steps away."
    subtitleLabel.font = UIFont(name: "OpenSans-Light", size: 12)
    subtitleLabel.textColor = UIColor(white: 1, alpha: 1)
    addSubview(subtitleLabel)
    
    addSubview(illustrationView)
    
    addSubview(instructionsView)
    
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    titleLabel.snp_remakeConstraints({ make in
      make.top.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    subtitleLabel.snp_remakeConstraints({ make in
      make.top.equalTo(self.titleLabel.snp_bottom).offset(20)
      make.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    illustrationView.snp_remakeConstraints({ make in
      make.top.equalTo(self.subtitleLabel.snp_bottom).offset(20)
      make.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
    
    instructionsView.snp_remakeConstraints({ make in
      make.top.equalTo(self.illustrationView.snp_bottom).offset(20)
      make.bottom.centerX.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    })
  }
}