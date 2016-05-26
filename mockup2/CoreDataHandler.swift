//
//  CoreDataHandler.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 25/04/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

//class for handling core data operations and shared vartiables
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

    func getLessonsTopics(lessonString: String){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "Topic")
        
        // Create Predicate
        let predicate = NSPredicate(format: "%K == %@", "lessonRelationship.lessonName", lessonString)
        fetchRequest.predicate = predicate
      
        
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
    
    func getLessonsFeedbacks(lessonString: String){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "Feedback2")
        
        // Create Predicate
        let predicate = NSPredicate(format: "%K == %@", "lessonRelationship.lessonName", lessonString)
        fetchRequest.predicate = predicate
        
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

}