//
//  Invite.swift
//  Lemonface
//
//  Created by rabzu on 06/08/2015.
//  Copyright (c) 2015 ooa. All rights reserved.
//

import Foundation
import CoreData

public class Invite: NSManagedObject {

    @NSManaged public var date: NSDate
    @NSManaged public var accepted: NSNumber
    @NSManaged public var invitationAddressee: Lemonface
    @NSManaged public var invitationAuthor: Lemonshop

}
