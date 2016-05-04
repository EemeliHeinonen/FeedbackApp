//
//  Lesson+CoreDataProperties.swift
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

extension Lesson {

    @NSManaged var lessonFeedback: Array<String>?
    @NSManaged var lessonRating: String?
    @NSManaged var subject: String?
    @NSManaged var time: String?
    @NSManaged var classroom: Classroom?
    @NSManaged var student: NSSet?
    @NSManaged var teacher: String?
    @NSManaged var topic: NSSet?

}
