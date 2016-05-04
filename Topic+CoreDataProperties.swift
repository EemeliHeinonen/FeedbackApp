//
//  Topic+CoreDataProperties.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 4.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Topic {

    @NSManaged var gotItrating: NSNumber?
    @NSManaged var notGotItrating: NSNumber?
    @NSManaged var topicName: String?
    @NSManaged var lesson: Lesson?
    @NSManaged var student: Student?

}
