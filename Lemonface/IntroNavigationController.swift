//
//  IntroNavigationController.swift
//  Lemonface
//
//  Created by rabzu on 13/08/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit

class IntroNavigationController: UINavigationController {

    var coreDataStack: CoreDataStack?
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        
        var lfIntroVC = storyboard.instantiateViewControllerWithIdentifier("LFIntroVC") as! LFIntroVC
        lfIntroVC.coreDataStack = coreDataStack
        self.pushViewController(lfIntroVC, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
