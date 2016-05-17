//
//  Topic+CoreDataProperties.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 17/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Topic {

    @NSManaged var gotItRating: String?
    @NSManaged var notGotItRating: String?
    @NSManaged var topicName: String?
    @NSManaged var lessonRelationship: Lesson?

}
