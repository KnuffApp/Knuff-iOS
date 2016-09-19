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
  case intro
  case success
  case failure
  
  func viewController() -> UIViewController? {
    switch self {
    case .intro:
      return IntroViewController()
    case .success:
      return SuccessViewController()
    case .failure:
      return FailureViewController()
    }
  }
}

class RootViewController: UIViewController {
  lazy var serviceAdvertiser = ServiceAdvertiser()

  var state: RootViewControllerState? {
    didSet {
      if (state != oldValue) {
        if (isViewLoaded) {
          
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
    contentContainerView!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    view.addSubview(contentContainerView!)
    
    
    infoCloseButton = InfoCloseButton(frame: CGRect.zero)
    infoCloseButton!.addTarget(
      self,
      action: #selector(RootViewController.toggleAbout),
      for: .touchUpInside
    )
    infoCloseButton!.sizeToFit()
    view.addSubview(infoCloseButton!)

    
    let displayedIntro = UserDefaults.standard.bool(forKey: DisplayedIntro)
    let application = UIApplication.shared
    
    if (state == nil) {
      if (!displayedIntro && !application.isRegisteredForRemoteNotifications) {
        state = .intro
      }
      else if (application.isRegisteredForRemoteNotifications) {
        state = .success
      }
      else {
        state = .failure
      }
    }
    
  }
  
  // or forward it to contentViewController
  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    infoCloseButton!.frame.origin = CGPoint(
      x: view.bounds.width - infoCloseButton!.bounds.width - 20,
      y: topLayoutGuide.length + 16
    )
  }
  
  // MARK: -
  
  func setContentViewController(_ viewController: UIViewController?, animated: Bool) {
    if let vc = contentViewController {
      vc.willMove(toParentViewController: nil)
      vc.view.removeFromSuperview()
      vc.removeFromParentViewController()
    }
    
    contentViewController = viewController
    
    if let vc = contentViewController {
      addChildViewController(vc)
      vc.view.frame = contentContainerView!.bounds
      vc.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      contentContainerView!.addSubview(vc.view)
      vc.didMove(toParentViewController: self)
    }
  }
  
  func toggleAbout() {
    let translateAnimation = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
    let contentAlphaAnimation = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
    let alphaAnimation = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
    let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
    
    if let vc = aboutViewController {
      vc.willMove(toParentViewController: nil)
      
      translateAnimation?.toValue = 0
      
      contentAlphaAnimation?.toValue = 1

      scaleAnimation?.toValue = NSValue(cgSize: CGSize(width: 0.75, height: 0.75))
      
      alphaAnimation?.toValue = 0
      
      infoCloseButton?.isEnabled = false
      alphaAnimation?.completionBlock = {(animation:POPAnimation?, completion:Bool) in
        
        self.infoCloseButton?.isEnabled = true
      
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
        
        self.aboutViewController = nil
      }
      
    } else {
      let vc = AboutViewController()
      addChildViewController(vc)

      vc.view.frame = view.bounds
      vc.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      
      // Initial state
      vc.view.alpha = 0
      vc.view.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            view.insertSubview(vc.view, belowSubview: contentContainerView!)
      
      translateAnimation?.toValue = -view.bounds.height
      
      contentAlphaAnimation?.toValue = 0
      
      scaleAnimation?.toValue = NSValue(cgSize: CGSize(width: 1, height: 1))
      
      alphaAnimation?.toValue = 1
      
      infoCloseButton?.isEnabled = false
      alphaAnimation?.completionBlock = {(animation:POPAnimation?, completion:Bool) in
      
        self.infoCloseButton?.isEnabled = true
        
        vc.didMove(toParentViewController: self)
      }
      
      aboutViewController = vc
    }
    
    contentContainerView!.layer.pop_add(translateAnimation, forKey: nil)
    contentContainerView!.pop_add(contentAlphaAnimation, forKey: nil)
    aboutViewController?.view.pop_add(scaleAnimation, forKey: nil)
    aboutViewController?.view.pop_add(alphaAnimation, forKey: nil)
  }
  
  
  // MARK: -
  
  func appDidRegisterForRemoteNotificationsWithDeviceToken(_ deviceToken: Data) {
    serviceAdvertiser.setDeviceToken(deviceToken)
    state = .success
  }
  
  func appDidFailToRegisterForRemoteNotificationsWithError(_ error: NSError) {
    serviceAdvertiser.setDeviceToken(nil)
    state = .failure
  }
}
