//
//  Lesson+CoreDataProperties.swift
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

extension Lesson {

    @NSManaged var lessonFeedback: String?
    @NSManaged var lessonRating: NSNumber?
    @NSManaged var subject: String?
    @NSManaged var time: String?
    @NSManaged var relationship: Classroom?
    @NSManaged var relationship1: NSManagedObject?
    @NSManaged var relationship2: NSSet?
    @NSManaged var relationship3: NSSet?

}
