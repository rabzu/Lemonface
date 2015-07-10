//
//  Tags.swift
//  Lemonface
//
//  Created by rabzu on 09/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

class Tags: NSManagedObject {

    @NSManaged var bar: NSNumber
    @NSManaged var floor: NSNumber
    @NSManaged var kitchen: NSNumber
    @NSManaged var lemonface: Lemonface
    @NSManaged var lemonshop: Lemonshop

}
