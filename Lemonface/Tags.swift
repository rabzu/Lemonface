//
//  Tags.swift
//  Lemonface
//
//  Created by rabzu on 17/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class Tags: NSManagedObject {

    @NSManaged public var bar: Bool
    @NSManaged public var floor: Bool
    @NSManaged public var kitchen: Bool
    @NSManaged public var lemonface: Lemonface
    @NSManaged public var lemonshop: Lemonshop

}
