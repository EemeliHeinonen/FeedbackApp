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

    
    //Method for saving students name
    
    func coreDataTestFunc(){
        print("coredatahandler test function is called")
        
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
    
}