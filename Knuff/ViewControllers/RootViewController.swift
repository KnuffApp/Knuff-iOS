//
//  RootViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 03/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

let RootViewControllerDisplayedIntro = "RootViewControllerDisplayedIntro"

class RootViewController: UIViewController {
  lazy var serviceAdvertiser = ServiceAdvertiser()
  var contentViewController: UIViewController?
  
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: "appDidBecomeActive",
      name: UIApplicationDidBecomeActiveNotification,
      object: nil
    )
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    view.backgroundColor = UIColor(hex: 0x1F3141, alpha: 1)
    
    let displayedIntro = NSUserDefaults.standardUserDefaults().boolForKey(RootViewControllerDisplayedIntro)
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
  
  // MARK: -
  
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
  
  // MARK: -
  
  func registerForRemoteNotifications() {
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: RootViewControllerDisplayedIntro)
    
    let application = UIApplication.sharedApplication()

    let current = application.currentUserNotificationSettings()
    
    let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound, categories: nil);
    

    application.registerUserNotificationSettings(settings)
    application.registerForRemoteNotifications();
  }
  
  // MARK: -
  
  func appDidBecomeActive() {
    let application = UIApplication.sharedApplication()
    
    if (application.isRegisteredForRemoteNotifications()) {
      println("Registered")
    } else {
      println("Not Registered")
    }
    
    let displayedIntro = NSUserDefaults.standardUserDefaults().boolForKey(RootViewControllerDisplayedIntro)
    
    if (displayedIntro && (serviceAdvertiser.deviceTokenString != nil)) {
      registerForRemoteNotifications()
    }
  }
  
  func appDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: NSData) {
    serviceAdvertiser.setDeviceToken(deviceToken)

    self.setContentViewController(SuccessViewController(), animated: false)
  }
  
  func appDidFailToRegisterForRemoteNotificationsWithError(error: NSError) {
    self.setContentViewController(FailureViewController(), animated: false)
  }
}
