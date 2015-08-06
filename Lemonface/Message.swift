//
//  Message.swift
//  Lemonface
//
//  Created by rabzu on 30/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class Message: NSManagedObject {

    @NSManaged public var date: NSDate
    @NSManaged public var text: String
    @NSManaged public var sentByLF: NSNumber
    @NSManaged public var lemonface: Lemonface
    @NSManaged public var lemonshop: Lemonshop

}
