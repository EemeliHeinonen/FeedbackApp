//
//  CoreDataHandler.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 25/04/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: UIViewController{
    
    static let sharedInstance = CoreDataHandler()
    
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var people = [NSManagedObject]()
    var lessons = [NSManagedObject]()
    var topics = [NSManagedObject]()
    var me = [NSManagedObject]()
    var lessonsTopics = [NSManagedObject]()
    var currentLesson = ""
    
    func zetCurrentLesson(s: String){
        currentLesson = s
    }
    
    func getCurrentLesson() -> String{
        return currentLesson
    }
    
    func getLessonsTopics(lessonString: String){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "Topic")
        
        // Create Predicate
        let predicate = NSPredicate(format: "%K == %@", "lessonRelationship.lessonName", lessonString)
        fetchRequest.predicate = predicate
        
        /*
        // Add Sort Descriptor
        let sortDescriptor1 = NSSortDescriptor(key: "last", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
         */
        
        // Execute Fetch Request
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest)
            print("?!?!?!??!?!?!?!??!?! result count:\(result.count)")
            print("?!?!?!??!?!?!?!??!?! result count:\(result)")
            
            lessonsTopics = result as! [NSManagedObject]
            
            for i in result {
                if let topicName = i.valueForKey("topicName"){
                    print("????????????? TÄSSÄ TULEE LESSONIN TOPICNAMET:\(topicName)")
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
    }
    
    //Method for saving students name
    func getAllTopics(){
        print("coredatahandler test function is called for topics")
        //this func gets all students
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Topic")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            topics = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    func coreDataTestFunc(){
        print("coredatahandler test function is called for students")
        //this func gets all students
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Student")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    func getAllLessons(){
        print("coredatahandler test function is called for lessons")
        //this func gets all lessons
        
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            lessons = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    func saveStudentName(name: String ) {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Student",
                                                        inManagedObjectContext:managedContext)
        
        let student = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        student.setValue(name, forKey: "studentName")
        
        //4
        do {
            try managedContext.save()
            //5
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    //Method for saving teachers name
    
    func saveTeacherName(name: String) {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Teacher",
                                                        inManagedObjectContext:managedContext)
        
        let teacher = NSManagedObject(entity: entity!,
                                      insertIntoManagedObjectContext: managedContext)
        
        //3
        teacher.setValue(name, forKey: "teacherName")
        
        //4
        do {
            try managedContext.save()
            //5
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    /*
    func test(){
        print("näin monta lessonia=======")
        print(lessons.count)
        
        for index in 0...lessons.count-1 {
            let subjectString = lessons[index].valueForKey("lessonName") as? String
            NetworkOperations.sharedInstance.getTopics(subjectString!)
            // TÄSTÄ JATKETAAN PERJANTAINA
            
            print("NYT LÄHTI GET TOPICS TÄLLÄ LESSONILLA ======")
            print(subjectString)
        }
    }
 */
}