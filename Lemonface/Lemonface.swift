//
//  Lemonface.swift
//  Lemonface
//
//  Created by rabzu on 09/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

class Lemonface: NSManagedObject {

    @NSManaged var bio: String
    @NSManaged var email: String
    @NSManaged var location: String
    @NSManaged var name: String
    @NSManaged var photoThumb: NSData
    @NSManaged var appliedShops: NSSet
    @NSManaged var interestedShops: Lemonshop
    @NSManaged var messages: NSSet
    @NSManaged var photo: ProfilePhoto
    @NSManaged var tags: Tags

}
