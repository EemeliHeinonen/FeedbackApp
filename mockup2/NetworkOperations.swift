//
//  ViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import Foundation

class NetworkOperations {
    
    static let sharedInstance = NetworkOperations()


    func getStuff(){
        //let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
    let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: sessionConfiguration)
    
    let sessionTask = session.dataTaskWithURL(NSURL(string: "http://localhost:8080/WebApplication5/")!, completionHandler: { (data, response, error) -> Void in
        
        //Define the operation we'd like to run in the operation queue
        let studentParseOperation = NSBlockOperation(block: {
            let parser = StudentParser()
            parser.parse(data!)
            //self.showTF.text = resultString
        })
        
        // create a queue and add the operation
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount=1
        queue.addOperation(studentParseOperation)
    })
    //.resume will cause the session task to execute
    
    sessionTask.resume()

    }
}

