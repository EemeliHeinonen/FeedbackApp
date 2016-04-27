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


class StudentParser: NSObject,NSXMLParserDelegate{
    
    
    var currentString = ""
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var thisStudent:Student?
    
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
        
        //Create new student object when <student> -tag is found
        if (elementName == "student") {
            print ("did start element student \(currentString)")
            thisStudent = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: managedContext!) as? Student
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //print("elementName= \(elementName)")
        
        if (elementName == "student") {
            print("did end element student \(currentString)")
        } else if(elementName == "name") {
            thisStudent?.studentName = currentString
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

