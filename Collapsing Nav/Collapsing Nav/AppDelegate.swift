//
//  AppDelegate.swift
//  Collapsing Nav
//
//  Created by Christian Noon on 2/8/15.
//  Copyright (c) 2015 Noondev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window = UIWindow(frame: UIScreen.mainScreen().bounds)
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window.rootViewController = RootViewController()
        
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()
        
        return true
    }
}
