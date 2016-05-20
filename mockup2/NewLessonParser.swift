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
    var thisClassroom:Classroom?
    var thisFeedback:Feedback?
    
    func parse (xmlData:NSData) {
        let myParser = NSXMLParser(data: xmlData)
        myParser.delegate = self
        myParser.parse()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        //CoreDataHandler.sharedInstance.clearTopicEntity()
        //CoreDataHandler.sharedInstance.clearLessonEntity()
        print ("******************************************* did start document")
        appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        managedContext = appDelegate!.managedObjectContext
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
            thisFeedback = NSEntityDescription.insertNewObjectForEntityForName("Feedback", inManagedObjectContext: managedContext!) as? Feedback
            print("!!!!!!!!!!!!!!!!!!!!!! Created a new feedback")
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
                
                let t = thisLesson!.mutableSetValueForKey("classroomRelationship") //good shit
                t.addObject(thisClassroom!)// good shit
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
                CoreDataHandler.sharedInstance.feedbacks.append(thisFeedback!) // Luo tämmönen CoreDataan.
                
                let t = thisLesson!.mutableSetValueForKey("feedbackRelationship") //good shit
                t.addObject(thisFeedback!)// good shit
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
        }else if (elementName == "teacher") {
            //thisLesson?.teacher = currentString
        } else if (elementName == "lessonRatingAvg") {
            if (currentString != "NaN"){
            thisLesson?.lessonRating = currentString
                print("RatingAvg set to \(currentString)")
            }
        }   else if (elementName == "feedbackText") {
            thisFeedback?.feedbackText = currentString
        }
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        print ("******************************************* did end document")
        //save the parsed objects to persistent storage
        do {
                       //try managedContext!.save()
        } catch let error as NSError {
            print("Saving failed with error \(error), \(error.userInfo)")
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print ("Error parsing document \(parseError)")
    }
    
}
