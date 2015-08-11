//
//  LemonshopMngrTest.swift
//  Lemonface
//
//  Created by rabzu on 26/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//
import XCTest
import CoreData
import Lemonface


class LemonshopMngrTest: XCTestCase {

    var coreDataStack: CoreDataStack!
    var lemonshopMngr:  LemonshopMngr!
    var lemonfaceMngr:  LemonfaceMngr!
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        lemonshopMngr = LemonshopMngr(managedObjectContext: coreDataStack.context, coreDataStack: coreDataStack)
        lemonfaceMngr = LemonfaceMngr(managedObjectContext: coreDataStack.context,
            coreDataStack: coreDataStack)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        lemonshopMngr = nil
        coreDataStack = nil
    }
    
    //For creating multiple profiles
    //We will use FB in future
    
    //Test adding profile to the model
    func testAddLemonshop(){
        
        let name = "Costa Coffe"
        let email = "careers@costa1.com"
        let image = UIImage(named:"shop.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let street = "Camden high street"
        let city = "London"
        let postCode = "nw1 9la"
        
        let shop = lemonshopMngr.addNewLemonshop(name, email: email, photo: photoData, street: street, city: city, postCode: postCode)
        
        
        XCTAssertNotNil(shop,  "Profile should not be nil")
        XCTAssertTrue(shop!.name == name)
        XCTAssertTrue(shop!.email == email)
        XCTAssertTrue(shop!.photo.photo == photoData)
        XCTAssertTrue(shop!.shopAddress.street == street)
        XCTAssertTrue(shop!.shopAddress.city == city)
        XCTAssertTrue(shop!.shopAddress.postcode == postCode)
    }
    //Adding an exsiting shop must return nil
    //temporary disabled
//    func testAddExistingLemonshop(){
//        
//        let name = "Costa Coffe"
//        let email = "careers@costa2.com"
//        let image = UIImage(named:"shop.jpg")
//        let photoData = UIImagePNGRepresentation(image)
//        let street = "Camden high street"
//        let city = "London"
//        let postCode = "nw1 9la"
//        
//        lemonshopMngr.addNewLemonshop(name, email: email, photo: photoData, street: street, city: city, postCode: postCode)
//        let shop = lemonshopMngr.addNewLemonshop(name, email: email, photo: photoData, street: street, city: city, postCode: postCode)
//        
//        
//        XCTAssertNil(shop,  "shop should be nil")
//    }
    //Test that exisiting profiles can be retreived using email
    func testGetExisitingLemonshop(){
        let name = "Costa Coffe"
        let email = "careers@costa3.com"
        let image = UIImage(named:"shop.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let street = "Camden high street"
        let city = "London"
        let postCode = "nw1 9la"
        lemonshopMngr.addNewLemonshop(name, email: email, photo: photoData, street: street, city: city, postCode: postCode)

        
       let shop = self.lemonshopMngr.getLemonshop(email)
     
        XCTAssertNotNil(shop,  "shop should not be nil")
        XCTAssertNotNil(shop,  "Profile should not be nil")
        XCTAssertTrue(shop!.name == name)
        XCTAssertTrue(shop!.email == email)
        XCTAssertTrue(shop!.photo.photo == photoData)
        XCTAssertTrue(shop!.shopAddress.street == street)
        XCTAssertTrue(shop!.shopAddress.city == city)
        XCTAssertTrue(shop!.shopAddress.postcode == postCode)
        
    }
    //Test that non exisiting shops are not retreived
    func testGetNonExisitingLemonshop(){
        let name = "Costa Coffe"
        let email = "careers@costa4.com"
        let image = UIImage(named:"shop.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let street = "Camden high street"
        let city = "London"
        let postCode = "nw1 9la"
        lemonshopMngr.addNewLemonshop(name, email: email, photo: photoData, street: street, city: city, postCode: postCode)
        let shop = self.lemonshopMngr.getLemonshop("shop@mail.com")
        XCTAssertNil(shop,  "Profile should not be nil")
    }
    
    // Test Profile deletion
    func testLemonfaceIsDeleted(){
        let name = "Costa Coffe"
        let email = "careers@costa5.com"
        let image = UIImage(named:"shop.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let street = "Camden high street"
        let city = "London"
        let postCode = "nw1 9la"
        
        let shop = lemonshopMngr.addNewLemonshop(name, email: email, photo: photoData, street: street, city: city, postCode: postCode)
        
        
        var fetchedShop = self.lemonshopMngr.getLemonshop(email)
        XCTAssertNotNil(fetchedShop, "profile should exist")
        self.lemonshopMngr.deleteLemonshop(email)
        fetchedShop = self.lemonshopMngr.getLemonshop(email)
        XCTAssertNil(fetchedShop, "shop shouldn't exist")
    }
    
    //Test Persistant Store Save
    func  testLemonshopIsSaved(){
        //1
        let expectRoot =  self.expectationForNotification(NSManagedObjectContextDidSaveNotification, object: coreDataStack.context){
                notification in
                return true
        }
        
        let name = "Costa Coffe"
        let email = "starbucks@mail.com"
        let image = UIImage(named:"shop.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let street = "Camden high street"
        let city = "London"
        let postCode = "nw1 9la"
        
        let shop = lemonshopMngr.addNewLemonshop(name, email: email, photo: photoData, street: street, city: city, postCode: postCode)
        
        coreDataStack.saveContext()
        
        //3
        self.waitForExpectationsWithTimeout(2.0){
            error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    
    func testAddLemonshopTags(){
        let name = "Costa Coffe"
        let email = "careers@costa7.com"
        let image = UIImage(named:"shop.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let street = "Camden high street"
        let city = "London"
        let postCode = "nw1 9la"
        
        let shop = lemonshopMngr.addNewLemonshop(name, email: email, photo: photoData, street: street, city: city, postCode: postCode)
        self.lemonshopMngr.addTags(shop!, bar: true, kitchen:false, floor: true)
        
        XCTAssertNotNil(shop!.tags, "Tags should exists")
        XCTAssert(shop!.tags.bar, "bar should be true")
        XCTAssert(shop!.tags.floor, "floor should be true")

        XCTAssertFalse(shop!.tags.kitchen, "Kitchen should be false")
    }
    //Test Message sending
    func testSendMessage(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Xavier Mascherano "
        let email = "Xavier@Masche99899.com"
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        
        let imageShop = UIImage(named:"shop.jpg")
        let photoDataShop = UIImagePNGRepresentation(imageShop)
        
        
        let shop = lemonshopMngr.addNewLemonshop("Costa Coffe", email: "careers@costaewewew.com", photo: photoDataShop,  street: "Camden high street", city: "London",  postCode: "nw1 9la")
        
        let msg = "Hello, I would like to apply"
        let message = lemonshopMngr.sendMessage(shop!, lf: profile!, txt: msg)
        
        XCTAssertNotNil(message, "Message should not be nil")
        XCTAssert(message!.text == msg, "Messages should be the same")
        XCTAssert(message!.sentByLF == false, "Must be false")
    }
    
    func testInviteLemonfaceSuccessfully(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Xavier Mascherano "
        let email = "X@M.com"
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)

        
        let imageShop = UIImage(named:"shop.jpg")
        let photoDataShop = UIImagePNGRepresentation(imageShop)
        let shop = lemonshopMngr.addNewLemonshop("Costa Coffe", email: "career@k.com", photo: photoDataShop,  street: "Camden high street", city: "London",  postCode: "nw1 9la")
        
        let invitation = lemonshopMngr.inviteCandidate(profile!, ls: shop!)
        
        XCTAssertNotNil(invitation, "invitiation should exists")
        XCTAssert(invitation!.invitationAuthor == shop, "application author should be the same")
        XCTAssert(profile?.invitationsReceived.count == 1, "there should be only one invition received")
        XCTAssert(shop?.invitationsMade.count == 1, "there should be only one invition made")
        XCTAssert(invitation!.invitationAddressee == profile, "invitation Adresse should be the same")
    }
 
}
