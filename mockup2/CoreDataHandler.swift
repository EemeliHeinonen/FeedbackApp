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
    
    //Method for saving students name
    
    func saveStudentName(name: String) {
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