//
//  ProfilePhoto.swift
//  Lemonface
//
//  Created by rabzu on 09/07/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

class ProfilePhoto: NSManagedObject {

    @NSManaged var photo: NSData
    @NSManaged var lemonface: Lemonface

}