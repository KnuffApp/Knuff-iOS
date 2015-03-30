//
//  IntoView.swift
//  Knuff
//
//  Created by Simon Blommegard on 26/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Cartography

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
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    layout(titleLabel, subtitleLabel, illustrationView) { titleLabel, subtitleLabel, illustrationView in
      titleLabel.top == titleLabel.superview!.top
      titleLabel.centerX == titleLabel.superview!.centerX
      titleLabel.superview!.width >= titleLabel.width
      
      subtitleLabel.centerX == subtitleLabel.superview!.centerX
      subtitleLabel.top == titleLabel.bottom + 20
      subtitleLabel.superview!.width >= subtitleLabel.width
      
      illustrationView.centerX == illustrationView.superview!.centerX
      illustrationView.top == subtitleLabel.bottom + 20
      illustrationView.superview!.width >= illustrationView.width
    }
    
    layout(illustrationView, instructionsView) { illustrationView, instructionsView in
      instructionsView.centerX == instructionsView.superview!.centerX
      instructionsView.top == illustrationView.bottom + 20
      instructionsView.superview!.width >= instructionsView.width
      instructionsView.bottom == instructionsView.superview!.bottom
    }
  }
}