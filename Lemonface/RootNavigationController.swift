//
//  RootNavigationController.swift
//  Lemonface
//
//  Created by rabzu on 08/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    var whoAmI: NSManagedObject!
    var coreDataStack: CoreDataStack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = self.setUpHeaderAnimation()
        self.pushViewController(controller!, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TODO: Split up this into functinos
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
        //TODO: profileCTR.coreDataStack = coreDataStack

        var candidatesCTR = storyboard.instantiateViewControllerWithIdentifier("CandidatesTVC") as! CandidatesTVC
        candidatesCTR.title = "Candidates"
        candidatesCTR.view.backgroundColor = UIColor.yellowColor()
        //TODO: candidatesCTR.coreDataStack = coreDataStack

        
        var applicantsCTR = storyboard.instantiateViewControllerWithIdentifier("ApplicantsTVC") as! ApplicantsTVC
        applicantsCTR.title = "Applicants"
        applicantsCTR.view.backgroundColor = gray
        applicantsCTR.coreDataStack = coreDataStack
        
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
    
    func gradient(percent: Double, topX: Double, bottomX: Double, initC: UIColor, goal: UIColor) -> UIColor{
        var t = (percent - bottomX) / (topX - bottomX)
        
        let cgInit = CGColorGetComponents(initC.CGColor)
        let cgGoal = CGColorGetComponents(goal.CGColor)
        
        
        var r = cgInit[0] + CGFloat(t) * (cgGoal[0] - cgInit[0])
        var g = cgInit[1] + CGFloat(t) * (cgGoal[1] - cgInit[1])
        var b = cgInit[2] + CGFloat(t) * (cgGoal[2] - cgInit[2])
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
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
