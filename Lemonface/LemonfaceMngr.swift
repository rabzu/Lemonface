//
//  LemonfaceMngr.swift
//  Lemonface
//
//  Created by rabzu on 09/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData


struct LemonfaceMngr{
    
    //MARK: Properties
    let managedObjectContext: NSManagedObjectContext!
    let coreDataStack: CoreDataStack!
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    func save(context: NSManagedObjectContext!){
//        coreDataStack.saveContext(context)
    }
//    @NSManaged var photoThumb: NSData
//    @NSManaged var appliedShops: NSSet
//    @NSManaged var interestedShops: Lemonshop
//    @NSManaged var messages: NSSet
//    @NSManaged var photo: ProfilePhoto
//    @NSManaged var tags: Tags


    //MARK: Insert and Upadate Operations
    func addLemonface(name: String,
                     email: String,
                     photo: NSData) -> Lemonface? {
            
            let lemonface = NSEntityDescription.insertNewObjectForEntityForName("Lemonface",
                                                                        inManagedObjectContext: self.managedObjectContext) as! Lemonface
            
            let profilePhoto = NSEntityDescription.insertNewObjectForEntityForName("ProfilePhoto",
                                                                        inManagedObjectContext: self.managedObjectContext) as! ProfilePhoto
            
            
            
            lemonface.name = name
            lemonface.email = email

            profilePhoto.photo = photo
            lemonface.photo = profilePhoto

             //Thumbnail
             lemonface.photoThumb = self.imageDataScaledToHeight(photo, height: 120)
            
            
            return lemonface
    }
    
    
    //MARK: Retrieve Operations
    func getProfile(email: String) -> Lemonface?{
        
        //var error: NSError?
        let fetchRequest = NSFetchRequest(entityName: "Lemonface")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        switch fetchRequestWrapper(managedObjectContext)(fetchRequest: fetchRequest){
            case let Result.Success(box):
                return box.unbox.first as! Lemonface?
            case let Result.Failure(error):
                println("Error getting profile. Error code: \(error.code)")
            return nil
        }
    }
    

    func deleteProfile(email: String){
        
        
        let fetchRequest = NSFetchRequest(entityName: "Lemonface")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        switch fetchRequestWrapper(managedObjectContext)(fetchRequest: fetchRequest){
            case let Result.Success(box):
                let p = box.unbox.first as! Lemonface
                managedObjectContext.deleteObject(p)
                println("profile deleted \(p.email)")
            case let Result.Failure(error):
                println("Error getting profile. Error code: \(error.code)")
        }
        
    }
    func imageDataScaledToHeight(imageData: NSData, height: CGFloat) -> NSData {
    
        let image = UIImage(data: imageData)!
        let oldHeight = image.size.height
        let scaleFactor = height / oldHeight
        let newWidth = image.size.width * scaleFactor
        let newSize = CGSizeMake(newWidth, height)
        let newRect = CGRectMake(0, 0, newWidth, height)
    
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(newRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return UIImageJPEGRepresentation(newImage, 0.8)
    }

    //TO DO: Asyncrhonous Fetching
    /*
    public func getProfile(peerID: MCPeerID) -> Profile?{
    
    
    var error: NSError?
    var results: [AnyObject]?
    
    self.managedObjectContext.performBlock { () -> Void in
    
    let fetchRequest = NSFetchRequest(entityName: "Profile")
    fetchRequest.predicate = NSPredicate(format: "peerID == %@", peerID)
    
    let  results = self.managedObjectContext.executeFetchRequest(fetchRequest, error: &error)
    let p = results?.first as Profile
    
    println("count insdie \(p.firstName)")
    }
    println("count outside \(results?.first)")
    if results == nil  {
    println("ERROR: \(error)")
    return nil
    }
    
    
    return results!.first as Profile?
    }
    */
    
}