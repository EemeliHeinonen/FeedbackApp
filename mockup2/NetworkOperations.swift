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
    var url:String
    
    init(){
        url = "localhost"
    }
    
    /*
     func getStudents(){
     //this function gets all students
     
     print("getStuff called")
     
     let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
     let session = NSURLSession(configuration: sessionConfiguration)
     
     let sessionTask = session.dataTaskWithURL(NSURL(string: "http://"+url+":8080/WebApplication5/webresources/Students/")!, completionHandler: { (data, response, error) -> Void in
     
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
     */

    
    
    func getLessons(){
        //this function gets all lessons
        
        print("getLessons called")
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: "http://"+url+":8080/WebApplication5/webresources/Courses/")!, completionHandler: { (data, response, error) -> Void in
            
            //Define the operation we'd like to run in the operation queue
            let studentParseOperation = NSBlockOperation(block: {
                let parser = NewLessonParser()
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
    
    func postStudent(c: String, s: String){
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let urli = "http://"+url+":8080/WebApplication5/webresources/Courses/"+c+"/students/"
        let escapedAddress = urli.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: escapedAddress!)
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        let body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n <student> <name>"+s+"</name> <id>76</id></student>\n"
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        let sessionTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            print("posting done, response = \(response), error = \(error)")
        })
        sessionTask.resume()
        
    }
    
    func postTopic(c: String, t: String){
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let urli = "http://"+url+":8080/WebApplication5/webresources/Courses/"+c+"/topics/"
        let escapedAddress = urli.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: escapedAddress!)
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        let body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n <topic> <topicName>"+t+"</topicName></topic>\n"
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        let sessionTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            print("posting done, response = \(response), error = \(error)")
        })
        sessionTask.resume()
        
    }
    
    func postTeacher(c: String, t: String){
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let urli = "http://"+url+":8080/WebApplication5/webresources/Courses/"+c+"/teachers/"
        let escapedAddress = urli.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: escapedAddress!)
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        let body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n <teacher> <name>"+t+"</name> <id>76</id></teacher>\n"
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        let sessionTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            print("posting done, response = \(response), error = \(error)")
        })
        sessionTask.resume()
        
    }
    
    func postLesson(name: String, time: String, classroom: String){
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "POST"
        request.URL = NSURL(string: "http://"+url+":8080/WebApplication5/webresources/Courses/")
        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        let body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n <course> <courseName>"+name+"</courseName> <time>"+time+"</time> <classroom>"+classroom+" </classroom><teachers><teacher></teacher></teachers><students></students><topics></topics> </course>\n"
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
        
        let sessionTask = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            print("posting done, response = \(response), error = \(error)")
        })
        sessionTask.resume()
        
    }
    
    func gotIt(course: String, topic: String){
        //this function gets all lessons
        
        print("gotIt called")
        let urli = "http://"+url+":8080/WebApplication5/webresources/Courses/"+course+"/topics/"+topic+"/gotItRating"
        let escapedAddress = urli.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        print(escapedAddress)
        

        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: escapedAddress!)!)
        //.resume will cause the session task to execute
        
        sessionTask.resume()
        
    }
    
    func notGotIt(course: String, topic: String){
        //this function gets all lessons
        
        print("notGotIt called")
        
        let urli = "http://"+url+":8080/WebApplication5/webresources/Courses/"+course+"/topics/"+topic+"/notGotItRating"
        let escapedAddress = urli.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        
        let sessionTask = session.dataTaskWithURL(NSURL(string: escapedAddress!)!
        )
        //.resume will cause the session task to execute
        
        sessionTask.resume()
        
    }
    
    func addStudentToLesson(student: String, lesson: String){
        
    
    }
}

