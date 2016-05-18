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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "lessonName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        clearLessonsEntity()
        self.refreshControl?.addTarget(self, action: #selector(TeacherLessonTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)

        super.viewDidLoad()
        title = "\"List of all Lessons\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
}
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    func getlessonsbyTeacher(){
        NetworkOperations.sharedInstance.getLessonsByTeacher((CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as? String)!)
    }
    func clearLessonsEntity(){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.executeRequest(deleteRequest)
            try managedContext.save()
            
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

        cell!.textLabel!.text =
            p.valueForKey("lessonName") as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        parentController!.performSegueWithIdentifier("teacherLessonSegue", sender: parentController)
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        CoreDataHandler.sharedInstance.getLessonsTopics(currentCell.textLabel!.text!)
        CoreDataHandler.sharedInstance.zetCurrentLesson(currentCell.textLabel!.text!)
        
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

