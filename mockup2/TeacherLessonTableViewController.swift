//
//  TeacherLessonTableViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

class TeacherLessonTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var parentController: TeacherMainViewController?
    
    var managedObjectContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let appDelegate = CoreDataHandler.sharedInstance.appDelegate//UIApplication.sharedApplication().delegate as! AppDelegate

        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        
        let predicate = NSPredicate(format: "ANY teacherRelationship.teacherName == %@", (CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as? String)!)
        fetchRequest.predicate = predicate
        
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "lessonName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataHandler.sharedInstance.managedContext! /*appDelegate.managedObjectContext*/, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        tableView.layer.borderWidth = 0.8
        let metropoliaColor = UIColor(red: 238.0/255.0, green: 103.0/255.0, blue: 7.0/255.0, alpha: 1)
        tableView.layer.borderColor = metropoliaColor.CGColor
        tableView.layer.cornerRadius = 5
        
         print("teacherlessontablecontroller view did load BAZINGGAAAAAAAAAAAAAAA ASD ")
        clearLessonsEntity()
        
        

        
        

        print("viewdidloadin parencontrollerprint")
        print(parentController)
        self.refreshControl?.addTarget(self, action: #selector(TeacherLessonTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)

        super.viewDidLoad()
        title = "\"List of all Lessons\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        }
    override func viewWillAppear(animated: Bool) {
        print("teacherlessontablecontroller view WILL APPEAR BAZINGGAAAAAAAAAAAAAAA ASD ")
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func getlessonsbyTeacher(){
        //NetworkOperations.sharedInstance.getLessonsByTeacher((CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as? String)!)
        NetworkOperations.sharedInstance.getLessons()
    }
    func clearLessonsEntity(){
        
        let appDelegate =
            CoreDataHandler.sharedInstance.appDelegate //UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = CoreDataHandler.sharedInstance.managedContext//appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext!.executeRequest(deleteRequest)
            try managedContext!.save()
            
            print("clearattu lesson entity")
        } catch let error as NSError {
            // TODO: handle the error
        }
 
        getlessonsbyTeacher()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numberOfSections = 1
        if let sections = fetchedResultsController.sections {
            numberOfSections = sections.count
        }
        return numberOfSections
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("func lessonntableView return count")
        print( CoreDataHandler.sharedInstance.lessons.count)
        
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("func tableView return cell")
        let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
        
        //let p = CoreDataHandler.sharedInstance.lessons[indexPath.row]
        let p = fetchedResultsController.objectAtIndexPath(indexPath)
        
        /*
        p.setValue("yes", forKey: "lessonStarted") // DING DING DING
        print("|||||||||||||||||||||||||||||| Value for lesson started: \(p.valueForKey("lessonStarted"))")
         */
        
        cell!.textLabel!.text =
            p.valueForKey("lessonName") as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(parentController)
        self.parentController!.performSegueWithIdentifier("teacherLessonViewSegue", sender: parentController)
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        CoreDataHandler.sharedInstance.getLessonsTopics(currentCell.textLabel!.text!)
        CoreDataHandler.sharedInstance.zetCurrentLesson(currentCell.textLabel!.text!)
        
        let p = fetchedResultsController.objectAtIndexPath(indexPath)
        
        
         p.setValue("yes", forKey: "lessonStarted") // DING DING DING
         print("|||||||||||||||||||||||||||||| Lesson \(p.valueForKey("lessonName"))'s Value for lesson started: \(p.valueForKey("lessonStarted"))")
      
        
        print(currentCell.textLabel!.text)
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
       
        refreshControl.endRefreshing()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!did change content")
        self.tableView.reloadData()
    }
}

