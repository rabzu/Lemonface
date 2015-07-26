//
//  LemonshopMngr.swift
//  Lemonface
//
//  Created by rabzu on 17/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation

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
public struct LemonshopMngr{
    
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
    public func addNewLemonshop(name: String,
                               email: String,
                               photo: NSData,
                              street: String,
                                city: String,
                            postCode: String) -> Lemonshop? {
        
        let lemonshop = NSEntityDescription.insertNewObjectForEntityForName("Lemonshop",
            inManagedObjectContext: self.managedObjectContext) as! Lemonshop
        
                                
                                
        let shopPhoto = NSEntityDescription.insertNewObjectForEntityForName("ShopPhoto",
            inManagedObjectContext: self.managedObjectContext) as! ShopPhoto
                                
        let address = NSEntityDescription.insertNewObjectForEntityForName("Address",
                                    inManagedObjectContext: self.managedObjectContext) as! Address
                                
        
        
        lemonshop.name = name
        lemonshop.email = email
                                
        address.street = street
        address.city = city
        address.postcode = postCode
                                
        lemonshop.shopAddress = address
            
        shopPhoto.photo = photo
        lemonshop.photo = shopPhoto
        
        //Thumbnail
        lemonshop.photoThumb = self.imageDataScaledToHeight(photo, height: 120)
        
        return lemonshop
    }
    
    
    //MARK: Retrieve Operations
    public func getLemonshop(email: String) -> Lemonface?{
        
        //var error: NSError?
        let fetchRequest = NSFetchRequest(entityName: "Lemonshop")
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        switch fetchRequestWrapper(managedObjectContext)(fetchRequest: fetchRequest){
        case let Result.Success(box):
            return box.unbox.first as! Lemonface?
        case let Result.Failure(error):
            println("Error getting profile. Error code: \(error.code)")
            return nil
        }
    }
    
    public func addBio(ls: Lemonshop, about: String){
        ls.about = about
    }
    
    //TODO: Insert Location
    //    func changeAddress(lf: Lemonface, location: Location){
    //
    //    }
    
    //Change Profile Photo
    func addPhoto(ls: Lemonshop, photo: NSData){
        ls.photoThumb = self.imageDataScaledToHeight(photo, height: 120)
        
        let shopPhoto = NSEntityDescription.insertNewObjectForEntityForName("ShopPhoto",
            inManagedObjectContext: self.managedObjectContext) as! ShopPhoto
        shopPhoto.photo = photo
        ls.photo = shopPhoto
    }
    
    public func deleteLemonshop(email: String){
        let fetchRequest = NSFetchRequest(entityName: "Lemonshop")
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
    
    //If a cafe likes an applicant, they can invite them: inserted in its list
    func inviteCandidate(lf:Lemonface, ls: Lemonshop){
        //If applicant has not alrady applied
        if !lf.appliedShops.containsObject(ls){
            //add the applied shop into the appliedShops set and make a new copy
            lf.appliedShops = lf.appliedShops.setByAddingObject(ls)
        }
        
    }
    //TODO: Cancel cancel
    func denyApplicant(lf:Lemonface, ls: Lemonshop){
        //you can only remove already existing shops
        if lf.appliedShops.containsObject(ls){
            //            let lfPredicate = NSPredicate(format: "%@", lf)
            //            lf.appliedShops = lf.appliedShops.filteredSetUsingPredicate(lfPredicate)
        }
        
    }
    
    func sendMessage(lf:Lemonface, ls: Lemonshop, txt: String){
        
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message",
            inManagedObjectContext: self.managedObjectContext) as! Message
        
        message.lemonshop = ls
        message.lemonface = lf
        message.text = txt
        message.date = NSDate()
    }
    
}