//
//  Classroom+CoreDataProperties.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 25/04/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Classroom {

    @NSManaged var beaconID: NSNumber?
    @NSManaged var roomName: String?
    @NSManaged var relationship: NSSet?

}
