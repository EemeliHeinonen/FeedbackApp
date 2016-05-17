//
//  StartViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 16.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData


class StartViewController: UIViewController{
    static let sharedInstance = StartViewController()

    
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var me = [NSManagedObject]()

    override func viewWillAppear(animated: Bool) {
        loadMyName()
        CoreDataHandler.sharedInstance.loadMyName()
        NetworkOperations.sharedInstance.getLessons()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    
    }
    func segueCheck(){
        
        if(me.count == 0){
            performSegueWithIdentifier("startSegue", sender: self)
        }
        else if(me.last?.valueForKey("teacherOrStudent") as? String == "teacher"){
            performSegueWithIdentifier("startSegue", sender: self)
        }
        else if(me.last?.valueForKey("teacherOrStudent") as? String == "student"){
            performSegueWithIdentifier("startSegue", sender: self)
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
            segueCheck()
        }catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    
}