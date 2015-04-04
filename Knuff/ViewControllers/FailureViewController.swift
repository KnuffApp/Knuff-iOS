//
//  FailureViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 01/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Snap

class FailureViewController: UIViewController {
  
  var failureView: FailureView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    failureView = FailureView(frame: CGRectZero)
    
    view.addSubview(failureView!)
    
    view.setNeedsUpdateConstraints()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    failureView?.pulseView.pulseView.startAnimations()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    
    failureView?.snp_remakeConstraints({ make in
      make.center.equalTo(self.view)
      return
    })
  }
}
