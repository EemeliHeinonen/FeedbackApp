//
//  StudentParser.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 20/04/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import Foundation



class GotItParser: NSObject,NSXMLParserDelegate{
    
    //
    //  StudentParser.swift
    //  mockup2
    //
    //  Created by Eemeli Heinonen on 20/04/16.
    //  Copyright © 2016 Mortti Aittokoski. All rights reserved.
    //
    
    
    
    
    
    var currentString = ""
    var appDelegate:AppDelegate?

    var thisStudent:Student?
    var gotItRating = ""
    var notGotItRating = ""
    
    func getGotItRating()-> String{
        return gotItRating
    }
    
    func parse (xmlData:NSData) {
        let myParser = NSXMLParser(data: xmlData)
        myParser.delegate = self
        myParser.parse()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print ("******************************************* did start document")

    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        print ("found characters: \(string)")
        currentString = string
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        print("found element: \(elementName)")

    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("elementName= \(elementName)")
        
        if (elementName == "gotItating") {
            gotItRating = currentString
            print("did end element gotItRating \(currentString)")
        } else if(elementName == "notGotItRating") {
            notGotItRating = currentString
            print("did end element notGotItRating \(currentString)")
            
        }
    }
    func parserDidEndDocument(parser: NSXMLParser){
        print ("******************************************* did end document")
        getGotItRating()
        print("getGotItRating called: \(getGotItRating())")
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

