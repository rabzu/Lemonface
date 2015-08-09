//
//  LemonfaceMngrTest.swift
//  Lemonface
//
//  Created by rabzu on 13/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import XCTest
import CoreData
import Lemonface

class LemonfaceMngrTest: XCTestCase {
    
    var coreDataStack: CoreDataStack!
    var lemonfaceMngr:  LemonfaceMngr!
    var lemonshopMngr:  LemonshopMngr!


    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        lemonfaceMngr = LemonfaceMngr(managedObjectContext: coreDataStack.context,
                                             coreDataStack: coreDataStack)
        lemonshopMngr = LemonshopMngr(managedObjectContext: coreDataStack.context,
                                             coreDataStack: coreDataStack)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        lemonfaceMngr = nil
        coreDataStack = nil
    }
    
    //For creating multiple profiles
    //We will use FB in future
  
     //Test adding profile to the model
    func testAddLemonface(){
        
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Tom Smith"
        let email = "tom@smith8.com"
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        
        XCTAssertNotNil(profile,  "Profile should not be nil")
        XCTAssertTrue(profile!.name == name)
        XCTAssertTrue(profile!.email == email)
        XCTAssertTrue(profile!.photo.photo == photoData)
    }
    
    func testAddExisitingLemonface(){
        
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Tom Smith"
        let email = "tom1@smith.com"
        lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)

        XCTAssertNil(profile,  "Profile should be nil")
    }
    
    
    //Test that exisiting profiles can be retreived using email
    func testGetExisitingLemonface(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Kun Aguero"
        let email = "Kun@Aguero.com"
         lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        

        let profile = self.lemonfaceMngr.getLemonface(email)
        XCTAssertNotNil(profile,  "Profile should not be nil")
        
    }
    
    //Test that non exisiting profiles are not retreived
    func testGetNonExisitingLemonface(){
        lemonfaceMngr.addNewLemonface("Tom Smith", email: "tom2@smith.com", photo:UIImagePNGRepresentation(UIImage(named:"lemon.jpg")))
        let profile = self.lemonfaceMngr.getLemonface("mark@tom.com")
        XCTAssertNil(profile,  "Profile should  be nil")
    }
    
    //Test Persistant Store Save
    func  testLemonfaceIsSaved(){
        //1
        let expectRoot =  self.expectationForNotification(
            NSManagedObjectContextDidSaveNotification,
            object: coreDataStack.context){
                notification in
                return true
        }
        
    
        let profile =  lemonfaceMngr.addNewLemonface("Tom Smith", email: "tom33311@gmail.o", photo:UIImagePNGRepresentation(UIImage(named:"lemon.jpg")))
        let bio = "I'm have a long experience in woring in bars. I make amazing Mojitos"
        lemonfaceMngr.addBio(profile!, bio: bio)
        
        coreDataStack.saveContext()

        //3
        self.waitForExpectationsWithTimeout(2.0){
            error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    // Test Profile deletion
    func testLemonfaceIsDeleted(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Leo Messi "
        let email = "leo@messi.com"
        
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
       
    
        var fetchedProfile = self.lemonfaceMngr.getLemonface(email)
        XCTAssertNotNil(fetchedProfile, "profile should exist")
        self.lemonfaceMngr.deleteLemonface(email)
        fetchedProfile = self.lemonfaceMngr.getLemonface(email)
        XCTAssertNil(fetchedProfile, "profile shouldn't exist")
    }
    
    //Test Adding Bio
    func testAddingBio(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Xavier Mascherano "
        let email = "Xavier@Masche.com"
        
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        let bio = "I'm have a long experience in woring in bars. I make amazing Mojitos"
        
        lemonfaceMngr.addBio(profile!, bio: bio)
        XCTAssertTrue(profile!.bio == bio)
    }
    //Add Tags to a profile
    func testAddLemonfaceTags(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Xavier Mascherano "
        let email = "Xavier3@Masche.com"
        
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        self.lemonfaceMngr.addTags(profile!, bar: true,  floor: true)
        XCTAssertNotNil(profile!.tags, "Tags should exists")
        
        XCTAssert(profile!.tags.bar, "bar should be true")
        XCTAssert(profile!.tags.floor, "flooe should be true")
        XCTAssertFalse(profile!.tags.kitchen, "kitchen should be fales by default")
  }
  //Test Message sending
    func testSendMessage(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Xavier Mascherano "
        let email = "Xavier4@Masche.com"
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        

        let imageShop = UIImage(named:"shop.jpg")
        let photoDataShop = UIImagePNGRepresentation(imageShop)
   
        
        let shop = lemonshopMngr.addNewLemonshop("Costa Coffe", email: "careers@costa434334.com", photo: photoDataShop,  street: "Camden high street", city: "London",  postCode: "nw1 9la")
        
        let msg = "Hello, I would like to apply"
        let message = lemonfaceMngr.sendMessage(profile!, ls: shop!, txt: msg)
        
        XCTAssertNotNil(message, "Message should not be nil")
        XCTAssert(message?.text == msg, "Messages should be the same")
        XCTAssert(message!.sentByLF == true, "Must be true")
        XCTAssert(message!.lemonshop == shop, "Must be same")
    }
    
    func testApplyToLemonshopSuccessfully(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Xavier Mascherano "
        let email = "Xavier5@Masche.com"
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        
        let imageShop = UIImage(named:"shop.jpg")
        let photoDataShop = UIImagePNGRepresentation(imageShop)
        let shop = lemonshopMngr.addNewLemonshop("Costa Coffe", email: "careers@costa54.com", photo: photoDataShop,  street: "Camden high street", city: "London",  postCode: "nw1 9la")
        
        let application = lemonfaceMngr.makeJobApplication(profile!,ls: shop!)
        
        XCTAssertNotNil(application, "application should exists")
        XCTAssert(application!.applicationAuthor == profile, "application author should be the same")
        XCTAssert(profile?.applicationsMade.count == 1, "there should be only one application")
        XCTAssert(shop?.applicationsReceived.count == 1, "there should be only one application")
        XCTAssert(application!.applicationAddressee == shop, "application Addresse should be the same")
    }
    
    func testApplyToAlreadyAppliedLemonshop(){
        
        let image = UIImage(named:"lemon.jpg")
        let email = "Xavier6434@Masche.com"
        let photoData = UIImagePNGRepresentation(image)
        let name = "Xavier Mascherano "
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        
        let imageShop = UIImage(named:"shop.jpg")
        let photoDataShop = UIImagePNGRepresentation(imageShop)
        let shop = lemonshopMngr.addNewLemonshop("Costa Coffe", email: "careers@costa654.com", photo: photoDataShop,  street: "Camden high street", city: "London",  postCode: "nw1 9la")
        
        let applicationFirst = lemonfaceMngr.makeJobApplication(profile!,ls: shop!)
        let applicationSecond = lemonfaceMngr.makeJobApplication(profile!,ls: shop!)

        XCTAssertNil(applicationSecond, "profile shouldn't exist")
    }
}
