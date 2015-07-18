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

    @NSManaged public var bio: String
    @NSManaged public var email: String
    @NSManaged public var location: String
    @NSManaged public var name: String
    @NSManaged public var photoThumb: NSData
    @NSManaged public var appliedShops: NSSet
    @NSManaged  var interestedShops: Lemonshop
    @NSManaged public var messages: NSSet
    @NSManaged public var photo: ProfilePhoto
    @NSManaged public var tags: Tags

}
