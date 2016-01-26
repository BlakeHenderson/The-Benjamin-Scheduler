//
//  Users.swift
//  Benjamin Scheduler
//
//  Created by Blake Henderson on 9/10/15.
//  Copyright © 2015 Blake Henderson. All rights reserved.
//

import UIKit
import CoreData

@objc(Users)
class Users: NSManagedObject {

    @NSManaged var username:String
    @NSManaged var password:String
}
