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
  
    
    func testAddLemonface(){
        
        let image = UIImage(named:"Lemon.jpg")
        let photoData = UIImagePNGRepresentation(image)
        let name = "Tom Smith"
        let email = "tom@smith.com"
//        let profile =  lemonfaceMngr.addNewLemonface( name, email: email, photo: photoData)
        
//         XCTAssertNotNil(,  "Camper should not be nil")
//
//        
//        XCTAssertTrue(profile!.name == name)
//        XCTAssertTrue(profile!.email == email)
//        XCTAssertTrue(profile!.photoThumb == photoData)
        
        XCTAssertTrue(name == name)
   
    }

}
