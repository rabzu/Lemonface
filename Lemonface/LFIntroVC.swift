//
//  LFInfoVC.swift
//  Lemonface
//
//  Created by rabzu on 05/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LFIntroVC: UIViewController, UIPageViewControllerDataSource {
    
    var coreDataStack: CoreDataStack?
    
    var pageViewController: UIPageViewController!

    let pageTitles = ["Intro 1", "Intro 2", "Intro 3"]
//    let pageImages = ["Intro 1", "Intro 2", "Intro 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpPageViewController()
        
        

    }
    deinit{
        NSLog("LFIntroVC deinit")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let loginVC = segue.destinationViewController as! LFLoginVC

        if segue.identifier == "toLemonShop" {
            loginVC.lemonface = false
            loginVC.coreDataStack = coreDataStack
        } else if segue.identifier == "toLemonFace" {
            println("Im lemonface to lemonface")
            loginVC.lemonface = true
        }
        
    }
    
    //MARK: Set up Page View Controller
    func setUpPageViewController(){
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageVC") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        var startVC = self.viewControllerAtIndex(0) as LFIntroContentVC
        
        var viewControllers = NSArray(object: startVC)
        
        
        
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
        
        
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMoveToParentViewController(self)

    }
    
    
     // MARK: - Page View Controller Delegate methods
    func viewControllerAtIndex(index: Int) -> LFIntroContentVC {
        
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            return LFIntroContentVC()
        }
        
        var vc: LFIntroContentVC = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentVC") as! LFIntroContentVC
        
//        vc.imageFile = self.pageImages[index]
        vc.titleText = self.pageTitles[index]
        vc.pageIndex = index
        
        return vc
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        
        var vc = viewController as! LFIntroContentVC
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound){
            return nil
         }
        index--
     
        return self.viewControllerAtIndex(index)
     }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! LFIntroContentVC
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound){
            return nil
        }
        index++
        
        if (index == self.pageTitles.count){
            return nil
        }
        return self.viewControllerAtIndex(index)
     }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return self.pageTitles.count
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
