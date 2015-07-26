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
    
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        lemonshopMngr = LemonshopMngr(managedObjectContext: coreDataStack.context, coreDataStack: coreDataStack)
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
        let email = "careers@costa.com"
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
    

}
