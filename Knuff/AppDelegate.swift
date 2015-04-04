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

  func applicationDidBecomeActive(application: UIApplication) {
    
    if (application.isRegisteredForRemoteNotifications()) {
      println("Registered")
    } else {
      println("Not Registered")
    }
    
    let current = application.currentUserNotificationSettings()
    
    
    let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound, categories: nil);
    
    application.registerUserNotificationSettings(settings)
    application.registerForRemoteNotifications();
  }
  
  func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    
  }
  
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    
  }
  
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    if let viewController = self.window?.rootViewController as? RootViewController {
      viewController.serviceAdvertiser.setDeviceToken(deviceToken)
      
      
    }
  }
  
  func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    if let viewController = self.window?.rootViewController as? RootViewController {

      
    }
  }

}

