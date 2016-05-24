//
//  StudentMainViewViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 12.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

class StudentMainViewViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "lessonsContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! testLessonsTableViewController
            destinationCtrl.parentController = self
        }
        if(segue.identifier == "StudentPastLessonsContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! StudentPastLessonsTableView
            destinationCtrl.parentController = self
        }
        if(segue.identifier == "studentLogoutSegue"){
            
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //CoreDataHandler.sharedInstance.appDelegate
                
                let managedContext = appDelegate.managedObjectContext //CoreDataHandler.sharedInstance.managedContext
                
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
            /*
        else if segue.identifier == "lessonSegue"{
            
            print("lessonSegue valittu")
            if let selectedLessonCell = sender as? StudentTopicsTableCellController{
                let indexPath = tableView.indexPathForCell(selectedLessonCell)!
                let selectedLesson = CoreDataHandler.sharedInstance.lessons[indexPath.row]
                let lessonString = selectedLesson.valueForKey("lessonName") as? String
                CoreDataHandler.sharedInstance.getLessonsTopics(lessonString!)
                print("prepare for segue valmis")
            }
        }
    }
    
}



override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "lessonSegue"{
        
                // Get the cell that generated this segue.
        
        if let selectedLessonCell = sender as? StudentTopicsTableCellController{
            let indexPath = tableView.indexPathForCell(selectedLessonCell)!
            let selectedLesson = CoreDataHandler.sharedInstance.lessons[indexPath.row]
            let lessonString = selectedLesson.valueForKey("lessonName") as? String
            CoreDataHandler.sharedInstance.getLessonsTopics(lessonString!)
            print("prepare for segue valmis")
        }
    }
 */
}
    