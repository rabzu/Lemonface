//
//  ApplicantsTVC.swift
//  Lemonface
//
//  Created by rabzu on 30/06/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit

class ApplicantsTVC: UITableViewController {

    var whoAmI: NSManagedObject!
    var managedObjectContext: NSManagedObjectContext!
    var coreDataStack: CoreDataStack!
    
    var fetchedResultsController : NSFetchedResultsController!
    
    @IBOutlet weak var titleLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpFetchedResultController()
   
        
     
        
    }
//    func setUpFetchedResultController(){
//        //Check wheather you are talking with Lemonshop or Lemonface
//        switch whoAmI {
//            case let lf as Lemonface:
//                //Retreive all the applicants who applied to the Employer
//                let fetchRequest = NSFetchRequest(entityName: "Application")
//                fetchRequest.predicate = NSPredicate(format: "applicationAuthor == @%", lf)
//            case let ls as Lemonshop:
//                //Retreive all the interested Employers who invited candidates
//                let fetchRequest = NSFetchRequest(entityName: "Invite")
//                fetchRequest.predicate = NSPredicate(format: "applicationAuthor == @%", ls)
//            default: break
//        }
////
//
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
//            managedObjectContext: managedObjectContext,
//            sectionNameKeyPath: nil,
//            cacheName: nil)
//        
//        fetchedResultsController.delegate = self
//        
//        var error: NSError? = nil
//        if (!fetchedResultsController.performFetch(&error)) {
//            println("Error: \(error?.localizedDescription)")
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
