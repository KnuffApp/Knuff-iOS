//
//  RootViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 03/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

let RootViewControllerDisplayedIntro = "RootViewControllerDisplayedIntro"

enum RootViewControllerState {
  case Intro
  case Success
  case Failure
  
  func viewController() -> UIViewController? {
    switch self {
    case .Intro:
      return IntroViewController()
    case .Success:
      return SuccessViewController()
    case .Failure:
      return FailureViewController()
    default:
      return nil
    }
  }
}

class RootViewController: UIViewController {
  lazy var serviceAdvertiser = ServiceAdvertiser()

  var state: RootViewControllerState? {
    didSet {
      if (state != oldValue) {
        if (isViewLoaded()) {
          
          // Animate
          if (contentViewController != nil) {}
          
          if let viewController = state?.viewController() {
            setContentViewController(viewController, animated: false)
          }
        }
      }
    }
  }
  
  var contentViewController: UIViewController?
  
  convenience init() {
    self.init(nibName: nil, bundle: nil)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    NSUserDefaults.standardUserDefaults().setBool(false, forKey: RootViewControllerDisplayedIntro)
    
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
    
    if (state == nil) {
      if (!displayedIntro && !application.isRegisteredForRemoteNotifications()) {
        state = .Intro
      }
      else if (application.isRegisteredForRemoteNotifications()) {
        state = .Success
      }
      else {
        state = .Failure
      }
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
      vc.view.autoresizingMask = .FlexibleHeight | .FlexibleWidth
      addChildViewController(vc)
      view.addSubview(vc.view)
      vc.didMoveToParentViewController(self)
    }
  }
  
  // MARK: -
  
  func registerForRemoteNotifications() {
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: RootViewControllerDisplayedIntro)
    
    let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound, categories: nil);
    
    let application = UIApplication.sharedApplication()
    
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
    
    if (displayedIntro) {
      registerForRemoteNotifications()
    }
  }
  
  func appDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: NSData) {
    serviceAdvertiser.setDeviceToken(deviceToken)
    state = .Success
  }
  
  func appDidFailToRegisterForRemoteNotificationsWithError(error: NSError) {
    serviceAdvertiser.setDeviceToken(nil)
    state = .Failure
  }
}
