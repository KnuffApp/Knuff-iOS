//
//  RootViewController.swift
//  Knuff
//
//  Created by Simon Blommegard on 03/04/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import pop

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
  
  var contentContainerView: UIView?
  var contentViewController: UIViewController?
  var aboutViewController: AboutViewController?
  var infoCloseButton: InfoCloseButton?
  
  override func viewDidLoad() {
    view.backgroundColor = UIColor(hex: 0x1F3141)
    
    contentContainerView = UIView(frame: view.bounds)
    contentContainerView!.autoresizingMask = .FlexibleHeight | .FlexibleWidth
    view.addSubview(contentContainerView!)
    
    
    infoCloseButton = InfoCloseButton(frame: CGRectZero)
    infoCloseButton!.addTarget(
      self,
      action: "toggleAbout",
      forControlEvents: .TouchUpInside
    )
    infoCloseButton!.sizeToFit()
    view.addSubview(infoCloseButton!)

    
    let displayedIntro = NSUserDefaults.standardUserDefaults().boolForKey(DisplayedIntro)
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
    return .LightContent
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    infoCloseButton!.frame.origin = CGPoint(
      x: view.bounds.width - infoCloseButton!.bounds.width - 20,
      y: topLayoutGuide.length + 16
    )
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
      addChildViewController(vc)
      vc.view.frame = contentContainerView!.bounds
      vc.view.autoresizingMask = .FlexibleHeight | .FlexibleWidth
      contentContainerView!.addSubview(vc.view)
      vc.didMoveToParentViewController(self)
    }
  }
  
  func toggleAbout() {
    let translateAnimation = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
    let contentAlphaAnimation = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
    let alphaAnimation = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
    let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    
    if let vc = aboutViewController {
      vc.willMoveToParentViewController(nil)
      
      translateAnimation.toValue = 0
      
      contentAlphaAnimation.toValue = 1

      scaleAnimation.toValue = NSValue(CGSize: CGSize(width: 0.75, height: 0.75))
      
      alphaAnimation.toValue = 0
      alphaAnimation.completionBlock = {(animation:POPAnimation!, completion:Bool) in
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
        
        self.aboutViewController = nil
      }
      
    } else {
      let vc = AboutViewController()
      addChildViewController(vc)

      vc.view.frame = view.bounds
      vc.view.autoresizingMask = .FlexibleHeight | .FlexibleWidth
      
      // Initial state
      vc.view.alpha = 0
      vc.view.transform = CGAffineTransformMakeScale(0.75, 0.75)
            view.insertSubview(vc.view, belowSubview: contentContainerView!)
      
      translateAnimation.toValue = -view.bounds.height
      
      contentAlphaAnimation.toValue = 0
      
      scaleAnimation.toValue = NSValue(CGSize: CGSize(width: 1, height: 1))
      
      alphaAnimation.toValue = 1
      alphaAnimation.completionBlock = {(animation:POPAnimation!, completion:Bool) in
        vc.didMoveToParentViewController(self)
      }
      
      aboutViewController = vc
    }
    
    contentContainerView!.layer.pop_addAnimation(translateAnimation, forKey: nil)
    contentContainerView!.pop_addAnimation(contentAlphaAnimation, forKey: nil)
    aboutViewController?.view.pop_addAnimation(scaleAnimation, forKey: nil)
    aboutViewController?.view.pop_addAnimation(alphaAnimation, forKey: nil)
  }
  
  
  // MARK: -
  
  func appDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: NSData) {
    serviceAdvertiser.setDeviceToken(deviceToken)
    state = .Success
  }
  
  func appDidFailToRegisterForRemoteNotificationsWithError(error: NSError) {
    serviceAdvertiser.setDeviceToken(nil)
    state = .Failure
  }
}
