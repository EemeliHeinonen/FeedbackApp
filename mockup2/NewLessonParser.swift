//
//  LessonParser.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 28.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class NewLessonParser: NSObject,NSXMLParserDelegate{
    
    var currentString = ""
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var thisLesson:Lesson?
    var thisTopic:Topic?
    var thisTeacher:Teacher?
    var thisStudent:Student?
    var thisClassroom:Classroom?
    var thisFeedback:Feedback2?
    
    func parse (xmlData:NSData) {
        let myParser = NSXMLParser(data: xmlData)
        myParser.delegate = self
        myParser.parse()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        
        //CoreDataHandler.sharedInstance.clearTopicEntity()
        //CoreDataHandler.sharedInstance.clearLessonEntity()
        print ("******************************************* did start document")
        appDelegate = CoreDataHandler.sharedInstance.appDelegate //(UIApplication.sharedApplication().delegate as! AppDelegate)
        managedContext = CoreDataHandler.sharedInstance.managedContext //appDelegate!.managedObjectContext
        
       /*
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext!.executeRequest(deleteRequest)
            try managedContext!.save()
            print("clearattu lesson entity")
        } catch let error as NSError {
            // TODO: handle the error
        }
*/
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        print ("found characters: \(string)")
        currentString = string
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("found element: \(elementName)")
        
        //Create new Lesson object when <course> -tag is found
        if (elementName == "course") {
            print ("did start element course")
            
            thisLesson = NSEntityDescription.insertNewObjectForEntityForName("Lesson", inManagedObjectContext: managedContext!) as? Lesson
            print("!!!!!!!!!!!!!!!!!!!!!! Created a new Lesson")
        } else if (elementName == "topic") {
            thisTopic = NSEntityDescription.insertNewObjectForEntityForName("Topic", inManagedObjectContext: managedContext!) as? Topic
            print("!!!!!!!!!!!!!!!!!!!!!! Created a new topic")
        } else if (elementName == "classroom") {
            thisClassroom = NSEntityDescription.insertNewObjectForEntityForName("Classroom", inManagedObjectContext: managedContext!) as? Classroom
            print("!!!!!!!!!!!!!!!!!!!!!! Created a new classroom")
        } else if (elementName == "feedback") {
            thisFeedback = NSEntityDescription.insertNewObjectForEntityForName("Feedback2", inManagedObjectContext: managedContext!) as? Feedback2
            print("!!!!!!!!!!!!!!!!!!!!!! Created a new feedback")
        } else if (elementName == "teacher") {
            thisTeacher = NSEntityDescription.insertNewObjectForEntityForName("Teacher", inManagedObjectContext: managedContext!) as? Teacher
            print("!!!!!!!!!!!!!!!!!!!!!! Created a new teacher")
        } else if (elementName == "student") {
            thisStudent = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: managedContext!) as? Student
            print("!!!!!!!!!!!!!!!!!!!!!! Created a new Student")
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName == "course") {
            CoreDataHandler.sharedInstance.lessons.append(thisLesson!)
            print("!!!!!!!!!!!!!!!!!!!!!! Appended the new lesson \(thisLesson?.lessonName) to the CoreData List")
            
        }  else if(elementName == "courseName") {
            thisLesson?.lessonName = currentString
            print("************** courseName changed to \(currentString)")
        } else if (elementName == "classroom") {
            if (thisClassroom?.roomName != "haamu") {
                
                
                thisLesson!.setValue((object: thisClassroom!), forKey: "classroomRelationship")
            }
        } else if (elementName == "topic") {
            if (thisTopic?.topicName != nil) {
                CoreDataHandler.sharedInstance.topics.append(thisTopic!)
            
                //thisLesson!.setValue(NSSet(object: thisTopic!), forKey: "topicRelationship")
                let t = thisLesson!.mutableSetValueForKey("topicRelationship") //good shit
                t.addObject(thisTopic!)// good shit
            
                print()
                //print("************** Topic \(thisTopic?.topicName!) added to \(thisLesson?.subject)'s topics list")
            }
        } else if (elementName == "feedback") {
            if (thisFeedback?.feedbackText != "haamu"){
                CoreDataHandler.sharedInstance.feedbacks.append(thisFeedback!)
                let t = thisLesson!.mutableSetValueForKey("feedbackRelationship") //good shit
                t.addObject(thisFeedback!)// good shit
            }
        } else if (elementName == "teacher") {
            if (thisTeacher?.teacherName != "haamu"){
                CoreDataHandler.sharedInstance.teachers.append(thisTeacher!)
                let t = thisLesson!.mutableSetValueForKey("teacherRelationship") //good shit
                t.addObject(thisTeacher!)// good shit
            }
        } else if (elementName == "student") {
            if (thisStudent?.studentName != "haamu"){
                CoreDataHandler.sharedInstance.students.append(thisStudent!)
                let t = thisLesson!.mutableSetValueForKey("studentRelationship") //good shit
                t.addObject(thisStudent!)// good shit
            }
        }
        
        else if (elementName == "topicName") {
            thisTopic?.topicName = currentString
        } else if (elementName == "gotItRating") {
            thisTopic?.gotItRating = currentString
        } else if (elementName == "notGotItRating") {
            thisTopic?.notGotItRating = currentString
        } else if (elementName == "room") {
            thisClassroom?.roomName = currentString
        } else if (elementName == "beaconId") {
            thisClassroom?.beaconID = currentString
        } else if (elementName == "teacherName") {
            thisTeacher?.teacherName = currentString
        } else if (elementName == "studentName") {
            thisStudent?.studentName = currentString
        } else if (elementName == "feedbackText") {
            thisFeedback?.feedbackText = currentString
        } else if (elementName == "rating") {
            thisFeedback?.lessonRating = currentString
        } else if (elementName == "lessonRatingAvg") {
            if (currentString != "NaN"){
            thisLesson?.lessonRatingAverage = currentString
                print("RatingAvg set to \(currentString)")
            }
        }
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        print ("******************************************* did end document")
        //save the parsed objects to persistent storage
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Saving failed with error \(error), \(error.userInfo)")
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print ("Error parsing document \(parseError)")
    }
    
}
