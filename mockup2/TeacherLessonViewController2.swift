//
//  TeacherLessonViewController2.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

class TeacherLessonViewController2: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "teacherTopicContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! TeacherTopicsTableController
            destinationCtrl.parentController = self
        }
    }
    
    @IBAction func getLessonsFromServerButtonAction(sender: UIButton) {
       
            let appDelegate =
                CoreDataHandler.sharedInstance.appDelegate //UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = CoreDataHandler.sharedInstance.managedContext//appDelegate.managedObjectContext
        
            print("clearattu kuule ihan kaikki mitä parsetaan")
        
        
        
        
        
            let fetchRequestLesson = NSFetchRequest(entityName: "Lesson")
            let deleteRequestLesson = NSBatchDeleteRequest(fetchRequest: fetchRequestLesson)
            
            let fetchRequestTopic = NSFetchRequest(entityName: "Topic")
            let deleteRequestTopic = NSBatchDeleteRequest(fetchRequest: fetchRequestTopic)
            
            let fetchRequestTeacher = NSFetchRequest(entityName: "Teacher")
            let deleteRequestTeacher = NSBatchDeleteRequest(fetchRequest: fetchRequestTeacher)
            
            let fetchRequestStudent = NSFetchRequest(entityName: "Student")
            let deleteRequestStudent = NSBatchDeleteRequest(fetchRequest: fetchRequestStudent)
            
            let fetchRequestFeedback2 = NSFetchRequest(entityName: "Feedback2")
            let deleteRequestFeedback2 = NSBatchDeleteRequest(fetchRequest: fetchRequestFeedback2)
            
            let fetchRequestClassroom = NSFetchRequest(entityName: "Classroom")
            let deleteRequestClassroom = NSBatchDeleteRequest(fetchRequest: fetchRequestClassroom)
        
        print("letit tehty")
            
            do {
                print("eka print Do:n jälkeen, ennen try")
                try managedContext!.executeRequest(deleteRequestLesson)
                print("ekan try:n jälkeen")
                try managedContext!.executeRequest(deleteRequestTopic)
                try managedContext!.executeRequest(deleteRequestTeacher)
                try managedContext!.executeRequest(deleteRequestStudent)
                try managedContext!.executeRequest(deleteRequestFeedback2)
                try managedContext!.executeRequest(deleteRequestClassroom)
                print("just ennen save")
               
                try managedContext!.save()
                print("do:n loppu, save tehty")
                

            } catch let error as NSError {
                // TODO: handle the error
            }
        print("catchin jälkeen")
        
        
        
        /*
            let fetchRequest = NSFetchRequest(entityName: "Topic")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try managedContext!.executeRequest(deleteRequest)
                try managedContext!.save()
                print("frankestain incoming")
                print(fetchRequest)
                
                print("clearattu lesson entity")
            } catch let error as NSError {
                // TODO: handle the error
            }
        */

        //NetworkOperations.sharedInstance.getLessons()
    }
    @IBAction func printCount(sender: UIButton) {
      
    }
}

