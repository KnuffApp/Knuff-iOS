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

    illustrationView = PushIllustrationView(frame: CGRect.zero)
    illustrationView!.sizeToFit()
    view.addSubview(illustrationView!)

    
    instructionsView = InstructionsView(frame: CGRect.zero)
    instructionsView!.sizeToFit()
    view.addSubview(instructionsView!)
    

    let image: UIImage
    
    if (traitCollection.horizontalSizeClass == .compact) {
      image = UIImage.drawableImage(CGSize(width: 1, height: 59),
        draw: { size in
          UIColor(hex: 0x6DB0F8, alpha: 0.4).set()
          UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1/UIScreen.main.scale))
      })
    } else {
      image = UIImage.drawableImage(CGSize(width: 248, height: 50),
        draw: { size in
          let rect = CGRect(
            x: 0.5,
            y: 0.5,
            width: size.width - 1.0,
            height: size.height - 1.0
          )
          UIColor(hex: 0x6DB0F8).set()
          UIBezierPath(roundedRect: rect, cornerRadius: 6).stroke()
      })
    }
    
    registerButton = UIButton()
    registerButton!.setTitle("GET STARTED", for: .normal)
    registerButton!.setBackgroundImage(image, for: .normal)
    registerButton!.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 12)
    registerButton!.setTitleColor(UIColor(hex: 0x6DB0F8), for: .normal)
    registerButton!.addTarget(
      self,
      action: #selector(IntroViewController.register),
      for: .touchUpInside
    )
    registerButton!.sizeToFit()
    view.addSubview(registerButton!)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    let compactWidth = (traitCollection.horizontalSizeClass == .compact)
    
    
    titleLabel!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (titleLabel!.bounds.width/2)),
      y: topLayoutGuide.length + 50
    )
    
    subtitleLabel!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (subtitleLabel!.bounds.width/2)),
      y: titleLabel!.frame.maxY + 16
    )

    instructionsView!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (instructionsView!.bounds.width/2)),
      y: round((view.bounds.height - instructionsView!.bounds.height) * 0.7)
    )
    
    let height = instructionsView!.frame.minY - subtitleLabel!.frame.maxY
    
    illustrationView!.frame.origin = CGPoint(
      x: round((view.bounds.width/2) - (illustrationView!.bounds.width/2)),
      y: subtitleLabel!.frame.maxY + round(height/2 - (illustrationView!.bounds.height/2))
    )
    
    if (compactWidth) {
      registerButton!.frame = CGRect(
        x: 0,
        y: view.bounds.height-registerButton!.bounds.height-bottomLayoutGuide.length,
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
  
  
  @objc func register() {
    if let delegate = UIApplication.shared.delegate as? AppDelegate {
      delegate.registerUserNotifications()
    }
  }
}
