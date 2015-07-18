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

    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        lemonfaceMngr = LemonfaceMngr(managedObjectContext: coreDataStack.context,
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
        let email = "tom@smith.com"
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        
        XCTAssertNotNil(profile,  "Profile should not be nil")
        XCTAssertTrue(profile!.name == name)
        XCTAssertTrue(profile!.email == email)
        XCTAssertTrue(profile!.photo.photo == photoData)
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
        lemonfaceMngr.addNewLemonface("Tom Smith", email: "tom@smith.com", photo:UIImagePNGRepresentation(UIImage(named:"lemon.jpg")))
        let profile = self.lemonfaceMngr.getLemonface("mark@tom.com")
        XCTAssertNil(profile,  "Profile should not be nil")
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
        
    
        let profile =  lemonfaceMngr.addNewLemonface("Tom Smith", email: "tom@smith.com", photo:UIImagePNGRepresentation(UIImage(named:"lemon.jpg")))
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
    //add Tags to a profile
    func addLemonfaceTags(){
        let image = UIImage(named:"lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Xavier Mascherano "
        let email = "Xavier@Masche.com"
        
        let profile =  lemonfaceMngr.addNewLemonface(name, email: email, photo: photoData)
        self.lemonfaceMngr.addTags(profile!, bar: true,  floor: true)
        XCTAssertNotNil(profile!.tags, "Tags should exists")
        
        XCTAssert(profile!.tags.bar, "bar should be true")
        XCTAssert(profile!.tags.floor, "flooe should be true")
        XCTAssertFalse(profile!.tags.kitchen, "kitchen should be fales by default")


    }
}
