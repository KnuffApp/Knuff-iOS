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
    titleLabel!.textColor = UIColor(hex: 0xF7F9FC)
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
    

    let image: UIImage
    
    if (self.traitCollection.horizontalSizeClass == .Compact) {
      image = UIImage.drawableImage(CGSize(width: 1, height: 59),
        draw: {
          UIColor(hex: 0x6DB0F8, alpha: 0.4).set()
          UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1/UIScreen.mainScreen().scale))
      })
    } else {
      image = UIImage.drawableImage(CGSize(width: 248, height: 50),
        draw: {
          let c = UIGraphicsGetCurrentContext()
          let rect = CGRect(
            x: 0.5,
            y: 0.5,
            width: Double(CGBitmapContextGetWidth(c)-1),
            height: Double(CGBitmapContextGetHeight(c)-1)
          )
          UIColor(hex: 0x6DB0F8).set()
          UIBezierPath(roundedRect: rect, cornerRadius: 6).stroke()
      })
    }
    
    registerButton = UIButton()
    registerButton!.setTitle("GET STARTED", forState: .Normal)
    registerButton!.setBackgroundImage(image, forState: .Normal)
    registerButton!.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 12)
    registerButton!.setTitleColor(UIColor(hex: 0x6DB0F8), forState: .Normal)
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
    
    if (self.traitCollection.horizontalSizeClass == .Compact) {
      registerButton!.frame = CGRect(
        x: 0,
        y: view.bounds.height-registerButton!.bounds.height,
        width: view.bounds.width,
        height: registerButton!.bounds.height
      )
    } else {
      registerButton!.frame.origin = CGPoint(
        x: round((view.bounds.width/2) - (registerButton!.bounds.width/2)),
        y: instructionsView!.frame.maxY + 20
      )
    }
  }
  
  
  func register() {
    if let vc = self.parentViewController as? RootViewController {      
      vc.registerForRemoteNotifications()
    }
  }
}
