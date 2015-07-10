//
//  Lemonshop.swift
//  Lemonface
//
//  Created by rabzu on 09/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

class Lemonshop: NSManagedObject {

    @NSManaged var about: String
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var photoThumb: NSData
    @NSManaged var street: String
    @NSManaged var city: String
    @NSManaged var postcode: String
    @NSManaged var applications: Lemonface
    @NSManaged var invitedFaces: NSSet
    @NSManaged var messages: NSSet
    @NSManaged var photo: ShopPhoto
    @NSManaged var tags: Tags

}
