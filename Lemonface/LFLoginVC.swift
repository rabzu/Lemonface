//
//  LFLoginVC.swift
//  Lemonface
//
//  Created by rabzu on 04/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON
import BrightFutures

class LFLoginVC: UIViewController, FBSDKLoginButtonDelegate {
    
    var coreDataStack: CoreDataStack?
    var pagesList:[JSON]? = []

    var lemonface: Bool = false
    let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    @IBAction func backPressed(sender: UIButton) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if lemonface{
            self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        } else {
            self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            self.loginButton.publishPermissions = ["manage_pages"]
        }
        self.loginButton.delegate = self
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    
        if( error != nil){
            //process error
              self.navigationController?.popToRootViewControllerAnimated(true)
        }else if result.isCancelled{
            //Handle cancelation
              self.navigationController?.popToRootViewControllerAnimated(true)
        } else {
            //If you ask for multiple permisssions at once, you should check if specific permission is missing
            println("login button did completeResult \(lemonface)")
            if lemonface == true {
                let storyboard = UIStoryboard(name:"Main", bundle:nil)
                let navigationController =  storyboard.instantiateViewControllerWithIdentifier("RootNavigationController") as! RootNavigationController
                
                //If app is already logged in Move straight to jobs
                navigationController.whoAmI = extractLemonface()
                println("HELLO  \(navigationController.whoAmI)")
               // appDelegate.window?.rootViewController = navigationController
//                self.performSegueWithIdentifier("toRootNavigationController", sender: self)
            } else if lemonface == false {
               //If its a lemonshop
                getPagesList()
               
            }
            
            if result.grantedPermissions.contains("email"){
                //Do Work
               
            }
           
        }
    }
    

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("logout")
    }
    //If you are looking for candidates and you are a lemonshop show list of Pages attached to your FB profile
    func getPagesList() {
         let pagesRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/accounts", parameters: nil)
        pagesRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if( error != nil){
                //process error
                println("Error : \(error)")
            } else{
                //                println("user: \(result.self)")
                
                let json = JSON(result)
                self.pagesList  = json["data"].array
                
//                if let l = pagesList{
//                        self.pagesList = l.map{$0["name"]}
//                }
                self.performSegueWithIdentifier("toPagePickerVC", sender: self)
            }
            
        })
    }
    //Create Lemonface and store it in the coredata->couchbase
    func extractLemonface() -> Lemonface?{
        var lf : Lemonface?
        
        println("Im extracting Lemonface from fb -> CD")

        let graphRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({
            (connection:FBSDKGraphRequestConnection!, result:AnyObject!, error:NSError!) -> Void in

            if( error != nil){
                //process error
                println("Error: \(error)")
            } else{
                
                let name: String = result.valueForKey("name") as! String
                let email: String = result.valueForKey("email") as! String
                
                println("name \(name) && EMAIL \(email)")
                
                let lemonfaceMngr = LemonfaceMngr(managedObjectContext: self.coreDataStack!.context, coreDataStack: self.coreDataStack!)
                
                if let profilePic = self.getFBProfilePic(){
                    lf = lemonfaceMngr.addNewLemonface(name, email: email, photo: profilePic)
                } else {
                    //lf = lemonfaceMngr.addNewLemonface(name, email: email, photo: nil)
                }
            }
        })
       return lf
    }
    func getFBProfilePic() -> NSData? {
        // Get user profile pic
        let url = NSURL(string: "https://graph.facebook.com/me/picture?type=large")
        let urlRequest = NSURLRequest(URL: url!)
        var pic: NSData?
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()){ (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            if( error != nil){
                println("hello \(data)")
                pic = data
            }
        }
        return pic
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toPagePickerVC" {

            let pagePickerVC = segue.destinationViewController as! LFPagePickerVC
            pagePickerVC.pagesList = self.pagesList

        } else if segue.identifier == "toRootNavigationController"{
            
        }
        
    }
   

}
