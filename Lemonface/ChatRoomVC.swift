//
//  ChatRoomVC.swift
//  Lemonface
//
//  Created by rabzu on 28/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import UIKit
import CoreData
import JSQMessagesViewController



class ChatRoomVC: JSQMessagesViewController, NSFetchedResultsControllerDelegate {

    var correspondent: NSManagedObject!
    var managedObjectContext: NSManagedObjectContext!
    var coreDataStack: CoreDataStack!
    
    var fetchedResultsController : NSFetchedResultsController!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpFetchedResultController()

        
        // Do any additional setup after loading the view.
    }
    
    func setUpFetchedResultController(){
        
        let fetchRequest = NSFetchRequest(entityName: "Message")
        
        //Check wheather you are talking with Lemonshop or Lemonface
        switch correspondent {
            case let ls as Lemonshop:  fetchRequest.predicate = NSPredicate(format: "Lemonshop == %@", ls)
            case let lf as Lemonface:  fetchRequest.predicate = NSPredicate(format: "Lemonface == %@", lf)
            default: break
        }
        

        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                      managedObjectContext: managedObjectContext,
                                                        sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        var error: NSError? = nil
        if (!fetchedResultsController.performFetch(&error)) {
            println("Error: \(error?.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let msg = fetchedResultsController.objectAtIndexPath(indexPath) as! Message
        var sender: String
        if msg.sentByLF == true {
           return JSQMessage(senderId: msg.lemonface.email, senderDisplayName: msg.lemonface.name, date: msg.date, text: msg.text)
        }else{
            return JSQMessage(senderId: msg.lemonshop.email, senderDisplayName: msg.lemonface.name, date: msg.date, text: msg.text)
        }
    }

}
