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
    
    
    lazy var coreDataStack = CoreDataStack()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let navigationController =  storyboard.instantiateViewControllerWithIdentifier("RootNavigationController") as! UINavigationController
        let controller = self.setUpHeaderAnimation()
        navigationController.pushViewController(controller!, animated: false)
        //If app is already logged in Move straight to jobs
      
        if (FBSDKAccessToken.currentAccessToken() != nil){
            
            println("Im here ")
            self.window?.rootViewController = navigationController
           
        
        }else{
            self.setUpIntroPageController()
            let introVC =  storyboard.instantiateViewControllerWithIdentifier("LFIntroVC") as! UIViewController
            self.window?.rootViewController = introVC
        }
        self.window?.backgroundColor = UIColor.whiteColor()
        self.window?.makeKeyAndVisible()
        
        


        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
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
    
    func setUpHeaderAnimation() -> SLPagingViewSwift?{
        var controller: SLPagingViewSwift?
        
        //        let viewController = navigationController.topViewController as! ViewController
        
        //        viewController.managedContext = coreDataStack.context
                var orange = UIColor.greenColor()
                var gray = UIColor.yellowColor()
        
               let storyboard = UIStoryboard(name:"Main", bundle:nil)
        
                var profileCTR = storyboard.instantiateViewControllerWithIdentifier("ProfileVC") as! ProfileVC
                profileCTR.title = "Profile"
                profileCTR.view.backgroundColor = orange
        
                var candidatesCTR = storyboard.instantiateViewControllerWithIdentifier("CandidatesTVC") as! CandidatesTVC
                candidatesCTR.title = "Candidates"
                candidatesCTR.view.backgroundColor = UIColor.yellowColor()
        
                var applicantsCTR = storyboard.instantiateViewControllerWithIdentifier("ApplicantsTVC") as! ApplicantsTVC
                applicantsCTR.title = "Applicants"
                applicantsCTR.view.backgroundColor = gray
        
                var img1 = UIImage(named: "gear")
                img1 = img1?.imageWithRenderingMode(.AlwaysTemplate)
                var img2 = UIImage(named: "profile")
                img2 = img2?.imageWithRenderingMode(.AlwaysTemplate)
                var img3 = UIImage(named: "chat")
                img3 = img3?.imageWithRenderingMode(.AlwaysTemplate)
        
        
                var items = [UIImageView(image: img1), UIImageView(image: img2), UIImageView(image: img3)]
                var controllers = [profileCTR, candidatesCTR, applicantsCTR]
                controller = SLPagingViewSwift(items: items, controllers: controllers, showPageControl: false)
        
                controller?.pagingViewMoving = ({ subviews in
                    for v in subviews {
                        var lbl = v as! UIImageView
                        var c = gray
        
                        if(lbl.frame.origin.x > 45 && lbl.frame.origin.x < 145) {
                            c = self.gradient(Double(lbl.frame.origin.x), topX: Double(46), bottomX: Double(144), initC: orange, goal: gray)
                        }
                        else if (lbl.frame.origin.x > 145 && lbl.frame.origin.x < 245) {
                            c = self.gradient(Double(lbl.frame.origin.x), topX: Double(146), bottomX: Double(244), initC: gray, goal: orange)
                        }
                        else if(lbl.frame.origin.x == 145){
                            c = orange
                        }
                        lbl.tintColor = c
                    }
                })
        
        return controller
        
    }
    
    func setUpIntroPageController(){
        var pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.backgroundColor = UIColor.whiteColor()

    }
    
    func gradient(percent: Double, topX: Double, bottomX: Double, initC: UIColor, goal: UIColor) -> UIColor{
        var t = (percent - bottomX) / (topX - bottomX)
        
        let cgInit = CGColorGetComponents(initC.CGColor)
        let cgGoal = CGColorGetComponents(goal.CGColor)
        
        
        var r = cgInit[0] + CGFloat(t) * (cgGoal[0] - cgInit[0])
        var g = cgInit[1] + CGFloat(t) * (cgGoal[1] - cgInit[1])
        var b = cgInit[2] + CGFloat(t) * (cgGoal[2] - cgInit[2])
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}

