//
//  ShopPhoto.swift
//  Lemonface
//
//  Created by rabzu on 15/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class ShopPhoto: NSManagedObject {

    @NSManaged public var photo: NSData
    @NSManaged public var lemonshop: Lemonshop

}
