//
//  Teacher+CoreDataProperties.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Teacher {

    @NSManaged var teacherName: String?
    @NSManaged var lessonRelationship: NSSet?

}
