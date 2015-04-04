//
//  RootViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 03/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

let AppDelegateDisplayedIntro = "AppDelegateDisplayedIntro"

class RootViewController: UIViewController {
  lazy var serviceAdvertiser = ServiceAdvertiser()
  var contentViewController: UIViewController?
  
  
  override func viewDidLoad() {
    view.backgroundColor = UIColor(hex: 0x1F3141, alpha: 1)
    
    let displayedIntro = NSUserDefaults.standardUserDefaults().boolForKey(AppDelegateDisplayedIntro)
    let application = UIApplication.sharedApplication()
    
    
    // Into view
    if (!displayedIntro && !application.isRegisteredForRemoteNotifications()) {
      setContentViewController(IntroViewController(), animated: false)
    }
    // Success view
    else if (application.isRegisteredForRemoteNotifications()) {
      setContentViewController(SuccessViewController(), animated: false)
    }
    // Failure view
    else {
      setContentViewController(FailureViewController(), animated: false)
    }
  }
  
  func setContentViewController(viewController: UIViewController?, animated: Bool) {
    if let vc = contentViewController {
      vc.willMoveToParentViewController(nil)
      vc.view.removeFromSuperview()
      vc.removeFromParentViewController()
    }

    contentViewController = viewController
    
    if let vc = contentViewController {
      vc.view.frame = self.view.bounds
      vc.view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
      addChildViewController(vc)
      view.addSubview(vc.view)
      vc.didMoveToParentViewController(self)
    }
  }
  
  // or forward it to contentViewController
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func supportedInterfaceOrientations() -> Int {
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact) {
      return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    } else {
      return Int(UIInterfaceOrientationMask.All.rawValue)
    }
  }
}
