//
//  Lemonface.swift
//  Lemonface
//
//  Created by rabzu on 15/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class Lemonface: NSManagedObject {

    @NSManaged var bio: String
    @NSManaged public var email: String
    @NSManaged var location: String
    @NSManaged public var name: String
    @NSManaged public var photoThumb: NSData
    @NSManaged var appliedShops: NSSet
    @NSManaged var interestedShops: Lemonshop
    @NSManaged var messages: NSSet
    @NSManaged public var photo: ProfilePhoto
    @NSManaged var tags: Tags

}
