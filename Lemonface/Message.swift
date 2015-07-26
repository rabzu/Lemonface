//
//  Message.swift
//  Lemonface
//
//  Created by rabzu on 15/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class Message: NSManagedObject {

    @NSManaged public var date: NSDate
    @NSManaged public var text: String
    @NSManaged public var lemonface: Lemonface
    @NSManaged public var lemonshop: Lemonshop

}
