//
//  Lemonshop.swift
//  Lemonface
//
//  Created by rabzu on 02/08/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class Lemonshop: NSManagedObject {

    @NSManaged public var about: String
    @NSManaged public var email: String
    @NSManaged public var name: String
    @NSManaged public var photoThumb: NSData
    @NSManaged public var messages: NSSet
    @NSManaged public var photo: ShopPhoto
    @NSManaged public var shopAddress: Address
    @NSManaged public var tags: Tags
    @NSManaged public var applicationsReceived: NSSet
    @NSManaged public var invitationsMade: NSSet

}
