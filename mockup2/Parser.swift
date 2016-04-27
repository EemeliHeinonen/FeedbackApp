//
//  StudentParser.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 20/04/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class Parser: NSObject,NSXMLParserDelegate{
    
    var currentString = ""
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var thisTeacher:Teacher?
    var thisTopic:Topic?
    var currentObj:String
    
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
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        //print("found element: \(elementName)")
        
        //Create new student object when start-tag is found
        if (elementName == "teacher") {
            currentObj = "teacher"
            print ("did start element teacher \(currentString)")
            thisTeacher = NSEntityDescription.insertNewObjectForEntityForName("Teacher", inManagedObjectContext: managedContext!) as? Teacher
        } else if (elementName == "topic") {
            currentObj = "topic"
            print ("did start element topic \(currentString)")
            thisTopic = NSEntityDescription.insertNewObjectForEntityForName("Topic", inManagedObjectContext: managedContext!) as? Topic
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("elementName= \(elementName)")
        
        if (elementName == "teacher") {
            print("did end element teacher \(currentString)")
        } else if(elementName == "name") {
            if (currentObj == "teacher"){
                thisTeacher?.teacherName = currentString
            } else if (currentObj == "topic") {
                thisTopic?.topicName = currentString
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

