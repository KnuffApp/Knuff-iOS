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

let DisplayedIntro = "DisplayedIntro"

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
  
  func applicationDidBecomeActive(application: UIApplication) {
    let displayedIntro = NSUserDefaults.standardUserDefaults().boolForKey(DisplayedIntro)
    
    if (displayedIntro && !application.isRegisteredForRemoteNotifications()) {
      registerUserNotifications()
    } else if (application.isRegisteredForRemoteNotifications()) {
      application.registerForRemoteNotifications()
    }
  }
  
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    
  }
  
  func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
    application.registerForRemoteNotifications()
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
  
  // MARK: -
  
  func registerUserNotifications() {
    NSUserDefaults.standardUserDefaults().setBool(true, forKey: DisplayedIntro)
    
    let settings = UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil);
    let application = UIApplication.sharedApplication()
    application.registerUserNotificationSettings(settings)
  }
}

