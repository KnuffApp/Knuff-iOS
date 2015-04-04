//
//  ViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 17/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Snap

class IntroViewController: UIViewController {
  var introView: IntoView?
  var infoCloseButton: InfoCloseButton?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    introView = IntoView(frame: CGRectZero)
    view.addSubview(introView!)
    
    infoCloseButton = InfoCloseButton(frame: CGRectZero)
    view.addSubview(infoCloseButton!)
    
    view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    super.updateViewConstraints()
    
    introView?.snp_remakeConstraints({ make in
      make.center.equalTo(self.view)
      return
    })
    
    infoCloseButton?.snp_remakeConstraints({ make in
      make.top.equalTo(self.view).offset(self.topLayoutGuide.length + 10)
      make.right.equalTo(self.view).offset(-10)
    })
  }
}
