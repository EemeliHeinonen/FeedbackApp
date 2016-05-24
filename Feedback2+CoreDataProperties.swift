//
//  Feedback2+CoreDataProperties.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 21/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Feedback2 {

    @NSManaged var feedbackText: String?
    @NSManaged var id: String?
    @NSManaged var lessonRating: String?
    @NSManaged var lessonRelationship: Lesson?

}