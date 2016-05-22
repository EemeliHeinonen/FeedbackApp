//
//  Lesson+CoreDataProperties.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 22.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Lesson {

    @NSManaged var lessonFeedback: String?
    @NSManaged var lessonName: String?
    @NSManaged var time: String?
    @NSManaged var lessonRatingAverage: String?
    @NSManaged var classroomRelationship: Classroom?
    @NSManaged var feedbackRelationship: NSSet?
    @NSManaged var studentRelationship: NSSet?
    @NSManaged var teacherRelationship: Teacher?
    @NSManaged var topicRelationship: NSSet?

}
