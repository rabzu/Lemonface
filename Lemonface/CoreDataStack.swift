//
//  CoreDataStack.swift
//  HitList
//
//  Created by James Nocentini on 19/02/2015.
//  Copyright (c) 2015 James Nocentini. All rights reserved.
//

import CoreData

//Public for testing purposes
public class CoreDataStack {
    //Public for testing purposes
    public let context:NSManagedObjectContext
    let psc:NSPersistentStoreCoordinator
    let model:NSManagedObjectModel
     let store:CBLIncrementalStore?
    //Public for testing purposes
    public init() {
        //1 Load the model that we defined in the .xcdatamodelmodelId files.
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("Lemonface", withExtension:"momd")
        model = NSManagedObjectModel.mergedModelFromBundles(nil)!.mutableCopy() as! NSManagedObjectModel
        
        //1.1  Call updateManagedObjectModel: to insure the Core Data model is mapped to a model Couchbase Lite understands.
        CBLIncrementalStore.updateManagedObjectModel(model)
        
        //2 Initialize the persistent store coordinator as usual
        psc = NSPersistentStoreCoordinator(managedObjectModel:model)
        
        //3 Set up the managed object context
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = psc
        
        //4
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory,
            inDomains: .UserDomainMask) as! [NSURL]
        
        //5 Check if the corresponding Couchbase Lite database exists. If so, we load the existing CBLDatabase as a CBLIncrementalStore store type. If not, we perform a migration from the previous SQLite data store to Couchbase Lite.
        let documentsURL = urls[0]
        let defaultStoreURL = documentsURL.URLByAppendingPathComponent("Lemonface")
        
        let options: NSDictionary = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        let databaseName = "lemonface"
        let storeURL = NSURL(string: databaseName)!
        var error: NSError? = nil
        
        if (!(CBLManager.sharedInstance().existingDatabaseNamed(databaseName, error: nil) != nil)) {
            let importStore = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: defaultStoreURL, options: options as [NSObject : AnyObject], error: nil)
            store = psc.migratePersistentStore(importStore!, toURL: storeURL, options: options as [NSObject : AnyObject], withType: CBLIncrementalStore.type(), error: nil) as? CBLIncrementalStore
        } else {
            store = psc.addPersistentStoreWithType(CBLIncrementalStore.type(), configuration: nil, URL: storeURL, options: options as [NSObject : AnyObject], error: &error) as? CBLIncrementalStore
        }
        

        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
        
        let url =  NSURL(string: "http://localhost:4984/lemonface/")
        let pull = store?.database.createPullReplication(url!)
        let push = store?.database.createPushReplication(url!)
        pull?.continuous = true
        push?.continuous = true
        
        pull?.start()
        push?.start()
        
    }
    
    func saveContext() {
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            println("Could not save: \(error), \(error?.userInfo)")
        }
    }
    
   
    
}