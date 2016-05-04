//
//  TopicParser.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 29.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TopicParser: NSObject,NSXMLParserDelegate{
    
    var currentString = ""
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var thisTopic:Topic?
    var thisLesson:Lesson?
    
    func parse (xmlData:NSData, nameoflesson:String) {
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
        
        //Create new student object when <student> -tag is found
        if (elementName == "topic") {
            print ("did start element topic \(currentString)")
            
            thisTopic = NSEntityDescription.insertNewObjectForEntityForName("Topic", inManagedObjectContext: managedContext!) as? Topic
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("elementName= \(elementName)")
        
        if (elementName == "topic") {
            CoreDataHandler.sharedInstance.topics.append(thisTopic!)
            
            print("did end element course, and appended to thisLesson\(currentString)")
        } else if(elementName == "name") {
            thisTopic?.topicName = currentString
            print("************** TOPIC \(currentString)")
            
        }
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        print ("******************************************* did end document")
        //save the parsed objects to persistent storage
        do {
            
            // valueForKey("subject") as? String
            // CoreDataHandler.sharedInstance.lessons[indexPath.row]
            
            //.setValue(NSSet(object: thisTopic!), forKey:"topic" )
            //try managedContext!.save()
        } catch let error as NSError {
            print("Saving failed with error \(error), \(error.userInfo)")
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print ("Error parsing document \(parseError)")
    }
    
}

