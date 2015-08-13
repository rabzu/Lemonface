//
//  AppDelegate.swift
//  Lemonface
//
//  Created by rabzu on 22/06/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
    
    lazy var coreDataStack = CoreDataStack()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NSNotificationCenter.defaultCenter().addObserver(     self,
                                                        selector: Selector("FBTokenChanged:"),
                                                            name: FBSDKAccessTokenDidChangeNotification,
                                                          object: nil)
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(     self,
                                                            selector: Selector("FBProfile:"),
                                                                name: FBSDKProfileDidChangeNotification,
                                                              object: nil)
        
        
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        let fbLaunch =  FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        FBSDKAccessToken.setCurrentAccessToken(nil)

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

        let rootNavigationController =  storyboard.instantiateViewControllerWithIdentifier("RootNavigationController") as! RootNavigationController
       
        //If app is already logged in Move straight to jobs
      
        if (FBSDKAccessToken.currentAccessToken() != nil){
            //pass the CDstack
            rootNavigationController.coreDataStack = coreDataStack
            self.window?.rootViewController = rootNavigationController
        }else{
            self.setUpIntroPageController()
            let introNVC =  storyboard.instantiateViewControllerWithIdentifier("IntroNavigationController") as! IntroNavigationController
            introNVC.coreDataStack = coreDataStack
            self.window?.rootViewController = introNVC
        }
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        
//

        return fbLaunch
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    func viewWithBackground(color: UIColor) -> UIView{
        var v = UIView()
        v.backgroundColor = color
        return v
    }
    
   
    
    func setUpIntroPageController(){
        var pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()

    }

    func FBTokenChanged(notification: NSNotification) {

        println(notification.userInfo)
    }
    
    func FBProfile(notification: NSNotification) {
      
        println(notification.userInfo)
    }
}

