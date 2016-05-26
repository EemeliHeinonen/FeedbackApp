//
//  StartViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 16.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

//class for the hidden start initializer viewcontroller for checking if the users name is stored and choosing the right segue based on that.
class StartViewController: UIViewController{
    static let sharedInstance = StartViewController()

    
    var appDelegate:AppDelegate?
    var managedContext:NSManagedObjectContext?
    var me = [NSManagedObject]()

    override func viewWillAppear(animated: Bool) {
        loadMyName()
        CoreDataHandler.sharedInstance.loadMyName()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    
    }
    func segueCheck(){
        
        if(me.count == 0){
            performSegueWithIdentifier("startSegue", sender: self)
        }
        else if(me.last?.valueForKey("teacherOrStudent") as? String == "teacher"){
            performSegueWithIdentifier("teacherStartSegue", sender: self)
        }
        else if(me.last?.valueForKey("teacherOrStudent") as? String == "student"){
            performSegueWithIdentifier("studentStartSegue", sender: self)
        }
    }
    
    func loadMyName(){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext      
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