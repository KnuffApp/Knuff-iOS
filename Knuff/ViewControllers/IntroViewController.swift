//
//  ViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 17/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
  var titleLabel: UILabel?
  var subtitleLabel: UILabel?
  var illustrationView: PushIllustrationView?
  var instructionsView: InstructionsView?
  
  var registerButton: UIButton?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel = UILabel()
    titleLabel!.text = "Let’s get started!"
    titleLabel!.font = UIFont(name: "OpenSans-Bold", size: 18)
    titleLabel!.textColor = UIColor(hex: 0xF7F9FC, alpha: 1)
    titleLabel!.sizeToFit()
    view.addSubview(titleLabel!)
    
    subtitleLabel = UILabel()
    subtitleLabel!.text = "Your first push is just a few steps away."
    subtitleLabel!.font = UIFont(name: "OpenSans-Light", size: 12)
    subtitleLabel!.textColor = UIColor(white: 1, alpha: 1)
    subtitleLabel!.sizeToFit()
    view.addSubview(subtitleLabel!)

    illustrationView = PushIllustrationView(frame: CGRectZero)
    illustrationView!.sizeToFit()
    view.addSubview(illustrationView!)

    
    instructionsView = InstructionsView(frame: CGRectZero)
    instructionsView!.sizeToFit()
    view.addSubview(instructionsView!)
    
    
    registerButton = UIButton()
    registerButton!.setTitle("Register", forState: .Normal)
    registerButton!.addTarget(
      self,
      action: "register",
      forControlEvents: .TouchUpInside
    )
    registerButton!.sizeToFit()
    view.addSubview(registerButton!)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    titleLabel!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (titleLabel!.bounds.width/2)),
      y: topLayoutGuide.length + 50
    )
    
    subtitleLabel!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (subtitleLabel!.bounds.width/2)),
      y: titleLabel!.frame.maxY + 16
    )
    
    illustrationView!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (illustrationView!.bounds.width/2)),
      y: subtitleLabel!.frame.maxY + 20
    )
    
    instructionsView!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (instructionsView!.bounds.width/2)),
      y: illustrationView!.frame.maxY + 20
    )
    
    registerButton!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (registerButton!.bounds.width/2)),
      y: instructionsView!.frame.maxY + 20
    )
  }
  
  
  func register() {
    if let vc = self.parentViewController as? RootViewController {      
      vc.registerForRemoteNotifications()
    }
  }
}
