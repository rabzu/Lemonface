//
//  LemonfaceMngr.swift
//  Lemonface
//
//  Created by rabzu on 09/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

//Public for testing purposes
public struct LemonfaceMngr{
    
    //MARK: Properties
    let managedObjectContext: NSManagedObjectContext!
    let coreDataStack: CoreDataStack!
    
    //Public for testing purposes
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    func save(context: NSManagedObjectContext!){
//        coreDataStack.saveContext(context)
    }


    //MARK: Insert and Upadate Operations
   public func addNewLemonface(name: String,  email: String, photo: NSData) -> Lemonface? {
            
    if getLemonface(email) == nil{
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
        return nil
    }
    
    
    //MARK: Retrieve Operations
   public func getLemonface(email: String) -> Lemonface?{
        
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
    
   public func addBio(lf: Lemonface, bio: String){
        lf.bio = bio
    }
    
    //TODO: Insert Location
//    func addLocation(lf: Lemonface, location: Location){
//        
//    }
    
    //Change Profile Photo
    func addPhoto(lf: Lemonface, photo: NSData){
        lf.photoThumb = self.imageDataScaledToHeight(photo, height: 120)
        
        let profilePhoto = NSEntityDescription.insertNewObjectForEntityForName("ProfilePhoto",
                                                                            inManagedObjectContext: self.managedObjectContext) as! ProfilePhoto
        profilePhoto.photo = photo
        lf.photo = profilePhoto
    }
    
   public func deleteLemonface(email: String){
         let fetchRequest = NSFetchRequest(entityName: "Lemonface")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        switch fetchRequestWrapper(managedObjectContext)(fetchRequest: fetchRequest){
            case let Result.Success(box):
                let p = box.unbox.first as! Lemonface
                managedObjectContext.deleteObject(p)
                println("profile deleted \(p.email)")
                //context should be saved so that delettion takes place
//                self.coreDataStack.saveContext()
            
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
    
    //If a candidate makes an applicaiton, the emplore is inserted in its list
    public func makeJobApplication(lf:Lemonface, ls: Lemonshop)->Application?{
        
        let fetchRequest = NSFetchRequest(entityName: "Application")
        fetchRequest.predicate = NSPredicate(format: "applicationAuthor == %@ && applicationAddressee == %@", lf, ls)

        switch fetchRequestWrapper(managedObjectContext)(fetchRequest: fetchRequest){
            //application alrady exisits
            case let Result.Success(box):
                let p = box.unbox as! [Application]
                if p.count == 0 {
                    let applicaiton = NSEntityDescription.insertNewObjectForEntityForName("Application", inManagedObjectContext: self.managedObjectContext) as! Application
                    applicaiton.applicationAuthor = lf
                    applicaiton.applicationAddressee = ls
                
                    return applicaiton
            }
            case let Result.Failure(error):
                //crate an application
                println("Error getting profile. Error code: \(error.code)")
            }
        return nil
    }
    
    
    //TODO: Cancel application
    func cancelJobApplication(lf:Lemonface, ls: Lemonshop){
        //you can only remove already existing shops
        let fetchRequest = NSFetchRequest(entityName: "Application")
        fetchRequest.predicate = NSPredicate(format: "application.author == %@ && application.addressee == %@", lf, ls)
//        switch fetchRequestWrapper(managedObjectContext)(fetchRequest: fetchRequest){
//            //application alrady exisits
//            case let Result.Success(box): break
//            case let Result.Failure(error):
//          
//        }
    }
    
   public func addTags(lf: Lemonface, bar: Bool = false, kitchen: Bool = false, floor: Bool = false){
        let tags = NSEntityDescription.insertNewObjectForEntityForName("Tags", inManagedObjectContext: self.managedObjectContext) as! Tags
        lf.tags = tags
        lf.tags.bar = bar
        lf.tags.floor = floor
        lf.tags.kitchen = kitchen
    }
    
    //MARK: Chat Manager
  public func sendMessage(lf:Lemonface, ls: Lemonshop, txt: String) -> Message?{
    
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message",
            inManagedObjectContext: self.managedObjectContext) as! Message
        
        message.lemonshop = ls
        message.lemonface = lf
        message.sentByLF = true
        message.text = txt
        message.date = NSDate()
    
        return message
    }
  
}