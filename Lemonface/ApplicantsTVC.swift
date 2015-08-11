//
//  ApplicantsTVC.swift
//  Lemonface
//
//  Created by rabzu on 30/06/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit

class ApplicantsTVC: UITableViewController, NSFetchedResultsControllerDelegate {

    var whoAmI: NSManagedObject!
    var managedObjectContext: NSManagedObjectContext!
    var coreDataStack: CoreDataStack!
    
    var fetchedResultsController : NSFetchedResultsController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFetchedResultController()
   
     }
    func setUpFetchedResultController(){
        //Check wheather you are talking with Lemonshop or Lemonface
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)

        switch whoAmI {
            case let lf as Lemonface:
                //If I am lemonface show me all the invites that I have received
                //Invitation is also send when the lemonface applies first to the lemonship
                let fetchRequest = NSFetchRequest(entityName: "Invite")
                fetchRequest.predicate = NSPredicate(format: "invitationAddressee == @%", lf)
                fetchRequest.sortDescriptors = [sortDescriptor]
                self.fetchedResultsController = NSFetchedResultsController(fetchRequest:            fetchRequest,
                    managedObjectContext: managedObjectContext,
                    sectionNameKeyPath: nil,
                    cacheName: nil)
            case let ls as Lemonshop:
                //Retreive all the interested Employers who invited candidates
                let fetchRequest = NSFetchRequest(entityName: "Application")
                fetchRequest.predicate = NSPredicate(format: "applicationAddressee == @%", ls)
                fetchRequest.sortDescriptors = [sortDescriptor]
                self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                    managedObjectContext: managedObjectContext,
                    sectionNameKeyPath: nil,
                    cacheName: nil)
            default: break
        }
     
        
        self.fetchedResultsController.delegate = self
        
        var error: NSError? = nil
        if (!fetchedResultsController.performFetch(&error)) {
            println("Error: \(error?.localizedDescription)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.fetchedResultsController.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        switch whoAmI {
            //If I'm a Lemonface show me names of all the Lemonshops who invited me
            case let lf as Lemonface:
                let invite = fetchedResultsController.objectAtIndexPath(indexPath) as! Invite
                cell.textLabel!.text = invite.invitationAuthor.name
            //If I'm a Lemonshop show me all the names of Lemonface who applied to me
            case let ls as Lemonshop:
                let application = fetchedResultsController.objectAtIndexPath(indexPath) as! Application
                cell.textLabel!.text = application.applicationAuthor.name
            default: break
        }

        return cell
    }
    //MARK: NSFetchedResultsController Delegate methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
            println("begin updets \(controller)")
            tableView.beginUpdates()
    }
    
    func controller (controller: NSFetchedResultsController,
        didChangeObject anObject: AnyObject,
        atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath?) {
            
            switch type {
                case .Insert:
                    println("insert")
                    tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
                case .Delete:
                    println("delete")
                    tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
                case .Update:
                    println("update")
//                     let cell = tableView.cellForRowAtIndexPath(indexPath!) //as TeamCell
//                    //configureCell(cell, indexPath: indexPath)
                case .Move:
                    println("move")
                    tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
                    tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
                default: break
            }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
            println("end updates")
            tableView.endUpdates()
    }
    
    
    
    // Override to support conditional editing of the table view.
   override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        // Return NO if you do not want the specified item to be editable.
        return false
    }
    
    


    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
