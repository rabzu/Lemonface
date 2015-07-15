//
//  Message.swift
//  Lemonface
//
//  Created by rabzu on 15/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

class Message: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var text: String
    @NSManaged var lemonface: Lemonface
    @NSManaged var lemonshop: Lemonshop

}
