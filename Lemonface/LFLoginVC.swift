//
//  LFLoginVC.swift
//  Lemonface
//
//  Created by rabzu on 04/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LFLoginVC: UIViewController, FBSDKLoginButtonDelegate {

    var lemonFace: Bool = false
    var lemonShop: Bool = false
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.currentAccessToken() != nil){
            //Segue
            println("User is already logged in")
             self.returnUserData()
        }
        else{
            if lemonFace{
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            } else if lemonShop{
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends", "manage_pages"]
            }
            self.loginButton.delegate = self
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        if( error != nil){
            //process error
        }else if result.isCancelled{
            //Handle cancelation
        } else {
            //If you ask for multiple permisssions at once, you should check if specific permission is missing
            if result.grantedPermissions.contains("email"){
                //Do Work
               
            }
           
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("logout")
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
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
