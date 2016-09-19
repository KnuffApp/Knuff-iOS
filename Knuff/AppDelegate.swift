//
//  AppDelegate.swift
//  Knuff
//
//  Created by Simon Blommegard on 17/03/15.
//  Copyright (c) 2015 Bowtie. All rights reserved.
//

import UIKit

let DisplayedIntro = "DisplayedIntro"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = RootViewController()
    
    window?.makeKeyAndVisible()
    
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    let displayedIntro = UserDefaults.standard.bool(forKey: DisplayedIntro)
    
    if (displayedIntro && !application.isRegisteredForRemoteNotifications) {
      registerUserNotifications()
    } else if (application.isRegisteredForRemoteNotifications) {
      application.registerForRemoteNotifications()
    }
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    
  }
  
  func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
    application.registerForRemoteNotifications()
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    if let vc = self.window?.rootViewController as? RootViewController {
      vc.appDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken)
    }
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    if let vc = self.window?.rootViewController as? RootViewController {
      vc.appDidFailToRegisterForRemoteNotificationsWithError(error as NSError)
    }
  }
  
  // MARK: -
  
  func registerUserNotifications() {
    UserDefaults.standard.set(true, forKey: DisplayedIntro)
    
    let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil);
    let application = UIApplication.shared
    application.registerUserNotificationSettings(settings)
  }
}

