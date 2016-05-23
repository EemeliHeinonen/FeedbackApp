//
//  CoreDataHandler.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 25/04/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler {
    
    static let sharedInstance = CoreDataHandler()
    
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var people = [NSManagedObject]()
    var lessons = [NSManagedObject]()
    var topics = [NSManagedObject]()
    var feedbacks = [NSManagedObject]()
    var me = [NSManagedObject]()
    var lessonsTopics = [NSManagedObject]()
    var students = [NSManagedObject]()
    var teachers = [NSManagedObject]()
    var currentFeedbackText = ""
    var currentLessonRating = ""
    var currentLesson = ""
    var currentLessonRatingAvg = ""
    
    init(){
        appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        managedContext = appDelegate!.managedObjectContext

    }
    
    func zetCurrentFeedbackText(s: String){
        currentFeedbackText = s
    }
    
    func getCurrentFeedbackText() -> String{
        return currentFeedbackText
    }
    
    func zetCurrentLessonRating(s: String){
        currentLessonRating = s
    }
    func getCurrentLessonRating() -> String{
        return currentLessonRating
    }
    
    func zetCurrentRatingAvg(s: String){
        currentLessonRatingAvg = s
    }
    
    func getCurrentRatingAvg() -> String{
        return currentLessonRatingAvg
    }
    
    func zetCurrentLesson(s: String){
        currentLesson = s
    }
    
    func getCurrentLesson() -> String{
        return currentLesson
    }
            
    func clearLessonEntity(){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.executeRequest(deleteRequest)
            try managedContext.save()
            getAllLessons()
            print("clearattu lesson entity")
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
    
    func clearMyName(){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Me")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.executeRequest(deleteRequest)
            try managedContext.save()
            getAllLessons()
            print("clearattu lesson entity")
        } catch let error as NSError {
            // TODO: handle the error
        }
    }


    
    func clearTopicEntity(){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "Topic")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            
            try managedContext.executeRequest(deleteRequest)
            try managedContext.save()
            print("clearattu topic entity")
        } catch let error as NSError {
            // TODO: handle the error
        }
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
    /*
     
     AIVAN ROSKA FUNCTIO
     
    func getLessonRatingAvg(lessonString: String) -> String{
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        
        // Create Predicate
        let predicate = NSPredicate(format: "%K == %@", "lessonName", lessonString)
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
            
            currentLessonRatingAvg = result as! [NSManagedObject]
            //let avg = currentLessonRatingAvg.last?.valueForKey("lessonRatingAverage") as! String
            //return avg
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        print("%(%(%(%/%/%/%(%/%(%/%%( lessonratingavg count")
        print(currentLessonRatingAvg.count)
        let ratingAvgValue = currentLessonRatingAvg.last?.valueForKey("lessonRatingAverage") as! String
        return ratingAvgValue
    }
    */
    func getLessonsFeedbacks(lessonString: String){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "Feedback2")
        
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
            
            feedbacks = result as! [NSManagedObject]
            
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
    /*
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
 */
    
    
    func getAllLessons(){
        print("coredatahandler function is called for getting lessons")
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
 
    func loadMyName(){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        
        let fetchRequest = NSFetchRequest(entityName: "Me")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            me = results as! [NSManagedObject]
            print("nimi loadattu coredatasta")
        }catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func saveMyName(name: String, type: String ) {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Me",
                                                        inManagedObjectContext:managedContext)
        let fetchRequest = NSFetchRequest(entityName: "Me")

        
        let mee = NSManagedObject(entity: entity!,
                                     insertIntoManagedObjectContext: managedContext)
        
        //3
        mee.setValue(name, forKey: "myName")
        mee.setValue(type, forKey: "teacherOrStudent")
        
        //4
        do {
            
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            me = results as! [NSManagedObject]
            try managedContext.save()
            //5
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    //Method for saving teachers name
   /*
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
 */
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