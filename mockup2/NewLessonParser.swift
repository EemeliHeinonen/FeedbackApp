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
    
    func parse (xmlData:NSData) {
        let myParser = NSXMLParser(data: xmlData)
        myParser.delegate = self
        myParser.parse()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
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
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName == "course") {
            CoreDataHandler.sharedInstance.lessons.append(thisLesson!)
            print("!!!!!!!!!!!!!!!!!!!!!! Appended the new lesson \(thisLesson?.lessonName) to the CoreData List")
            
        } else if(elementName == "courseName") {
            thisLesson?.lessonName = currentString
            print("************** courseName changed to \(currentString)")
        } else if (elementName == "topic") {
            CoreDataHandler.sharedInstance.topics.append(thisTopic!)
            
            //thisLesson!.setValue(NSSet(object: thisTopic!), forKey: "topicRelationship")
            let t = thisLesson!.mutableSetValueForKey("topicRelationship") //good shit
            t.addObject(thisTopic!)// good shit
            
            print()
            //print("************** Topic \(thisTopic?.topicName!) added to \(thisLesson?.subject)'s topics list")
        } else if (elementName == "topicName") {
            thisTopic?.topicName = currentString
        } else if (elementName == "gotItRating") {
            thisTopic?.gotItRating = currentString
        } else if (elementName == "notGotItRating") {
            thisTopic?.notGotItRating = currentString
        } else if (elementName == "teacher") {
            //thisLesson?.teacher = currentString
        }/* else if (elementName == "lessonRatingAvg") {
            if (currentString != "NaN"){
            thisLesson?.lessonRating = currentString
            }
        } */ else if (elementName == "classroom") {
          
        } else if (elementName == "feedback") {
            //thisLesson?.lessonFeedback?.append(currentString)
            //print("\(currentString) Added to lessons feedback list")
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
