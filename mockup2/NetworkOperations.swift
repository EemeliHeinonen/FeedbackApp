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
        //this function gets all students
        
        print("getStuff called")
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: "http://localhost:8080/WebApplication5/webresources/Students/")!, completionHandler: { (data, response, error) -> Void in
            
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
    func getTopics(){
        //this function gets all students
        
        print("getStuff called")
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: "http://localhost:8080/WebApplication5/webresources/Courses/Quantum Mechanics/topics/{topic})")!, completionHandler: { (data, response, error) -> Void in
            
            //Define the operation we'd like to run in the operation queue
            let studentParseOperation = NSBlockOperation(block: {
                let parser = TopicParser()
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
    
    func getLessons(){
        //this function gets all lessons
        
        print("getLessons called")
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: "http://localhost:8080/WebApplication5/webresources/Courses/")!, completionHandler: { (data, response, error) -> Void in
            
            //Define the operation we'd like to run in the operation queue
            let studentParseOperation = NSBlockOperation(block: {
                let parser = LessonParser()
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
    
    func postStuff(s: String){
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "http://localhost:8080/WebApplication5/webresources/Students/")
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        let body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n <student> <name>"+s+"</name> <id>76</id></student>\n"
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        let sessionTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            print("posting done, response = \(response), error = \(error)")
        })
        sessionTask.resume()
        
    }
    
    func postLesson(name: String, time: String){
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "http://localhost:8080/WebApplication5/webresources/Courses/")
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        let body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n <course> <name>"+name+"</name> <time>"+time+"</time> </course>\n"
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        let sessionTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            print("posting done, response = \(response), error = \(error)")
        })
        sessionTask.resume()
        
    }
}

