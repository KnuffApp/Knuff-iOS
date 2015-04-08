//
//  AppDelegate.swift
//  Knuff
//
//  Created by Simon Blommegard on 17/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.rootViewController = RootViewController()
    
    Fabric.with([Crashlytics()])
    
    window?.makeKeyAndVisible()
    
    return true
  }
  
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    
  }
  
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    if let vc = self.window?.rootViewController as? RootViewController {
      vc.appDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken)
    }
  }
  
  func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    if let vc = self.window?.rootViewController as? RootViewController {
      vc.appDidFailToRegisterForRemoteNotificationsWithError(error)
    }
  }
}

