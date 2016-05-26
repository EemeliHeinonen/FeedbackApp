//
//  TeacherMainViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

// class for the main view for teacher, showing the created lessons and past lessons
class TeacherMainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "TeacherLessonContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! TeacherLessonTableViewController
            destinationCtrl.parentController = self
        }
        if(segue.identifier == "TeacherPastLessonEmbedSegue"){
            let destinationCtrl = segue.destinationViewController as! TeacherPastLessonTableViewController
            destinationCtrl.parentController = self
        }
        if(segue.identifier == "teacherLogoutSegue"){
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Me")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try managedContext.executeRequest(deleteRequest)
                try managedContext.save()
                
                print("clearattu me entity")
            } catch let error as NSError {
                // TODO: handle the error
            }
        }
    }
}

