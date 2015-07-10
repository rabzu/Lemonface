//
//  LFPagePickerVC.swift
//  Lemonface
//
//  Created by rabzu on 08/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import SwiftyJSON

class LFPagePickerVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var pagesList:[JSON]?
    
    let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate

    @IBAction func nextPressed(sender: UIButton) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let navigationController =  storyboard.instantiateViewControllerWithIdentifier("RootNavigationController") as! UINavigationController
        
        //If app is already logged in Move straight to jobs
        appDelegate.window?.rootViewController = navigationController
        println(self.pickerView.selectedRowInComponent(0))
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.pickerView.reloadAllComponents()
   

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int,  forComponent component: Int) -> String?{
            return  self.pagesList![row]["name"].string
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        if let c = self.pagesList?.count{ return c}
        else{ return 0}
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //Initializes a new instance that use use [FBSDKAccessToken currentAccessToken].
    
    
    
}
