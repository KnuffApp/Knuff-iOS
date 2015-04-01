//
//  SuccessViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 30/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import pop
import Cartography

class SuccessViewController: UIViewController {

  var successView: SuccessView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(hex: 0x1F3141, alpha: 1)
    
    successView = SuccessView(frame: CGRectZero)
    
    view.addSubview(successView!)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    successView?.pulseView.startAnimations()
  }

  override func updateViewConstraints() {
    super.updateViewConstraints()
    
    layout(successView!) { successView in
      successView.center == successView.superview!.center
      return
    }
  }
}
