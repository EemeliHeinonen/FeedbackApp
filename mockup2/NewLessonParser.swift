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
            print ("did start element course \(currentString)")
            
            thisLesson = NSEntityDescription.insertNewObjectForEntityForName("Lesson", inManagedObjectContext: managedContext!) as? Lesson
        } else if (elementName == "topic") {
            thisTopic = NSEntityDescription.insertNewObjectForEntityForName("Topic", inManagedObjectContext: managedContext!) as? Topic
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("elementName= \(elementName)")
        
        if (elementName == "course") {
            CoreDataHandler.sharedInstance.lessons.append(thisLesson!)
            print("did end element course, and appended to thisLesson\(currentString)")
            
        } else if(elementName == "courseName") {
            thisLesson?.subject = currentString
            print("************** subject \(currentString)")
        } else if (elementName == "topic") {
            
        }
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        print ("******************************************* did end document")
        //save the parsed objects to persistent storage
        do {
            CoreDataHandler.sharedInstance.test()
            
            //try managedContext!.save()
        } catch let error as NSError {
            print("Saving failed with error \(error), \(error.userInfo)")
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print ("Error parsing document \(parseError)")
    }
    
}
