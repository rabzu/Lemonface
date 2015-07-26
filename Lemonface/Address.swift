//
//  Address.swift
//  Lemonface
//
//  Created by rabzu on 27/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class Address: NSManagedObject {

    @NSManaged public var city: String
    @NSManaged public var postcode: String
    @NSManaged public var street: String
    @NSManaged public var owner: Lemonshop

}
