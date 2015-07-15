//
//  ProfilePhoto.swift
//  Lemonface
//
//  Created by rabzu on 15/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class ProfilePhoto: NSManagedObject {

    @NSManaged public var photo: NSData
    @NSManaged var lemonface: Lemonface

}
