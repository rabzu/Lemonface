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

class LFLoginVC: UIViewController, FBSDKLoginButtonDelegate {

    var pagesList:[JSON]? = []

    var lemonFace: Bool = false
    var lemonShop: Bool = false
    let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    @IBAction func backPressed(sender: UIButton) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      
            if lemonFace{
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            } else if lemonShop{
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
        }else if result.isCancelled{
            //Handle cancelation
        } else {
            //If you ask for multiple permisssions at once, you should check if specific permission is missing
            if lemonFace == true {
                
                let storyboard = UIStoryboard(name:"Main", bundle:nil)
                let navigationController =  storyboard.instantiateViewControllerWithIdentifier("RootNavigationController") as! UINavigationController
                
                //If app is already logged in Move straight to jobs
                appDelegate.window?.rootViewController = navigationController
//                self.performSegueWithIdentifier("toRootNavigationController", sender: self)
            } else if lemonShop == true {
                
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
    
    private let pagesRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/accounts", parameters: nil)
    func getPagesList() {
        self.pagesRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if( error != nil){
                //process error
                println("Error 22: \(error)")
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
    

    
    func returnUserData(){
        let graphRequest: FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
       
        graphRequest.startWithCompletionHandler({
            
            
            (connection, result, error) -> Void in
            
                if( error != nil){
                    //process error
                    println("Error: \(error)")
                } else{
                    println("user: \(result)")
                     let userName: String = result.valueForKey("name") as! String
                    let userEmail: String = result.valueForKey("email") as! String
                }
            
        })
        
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
