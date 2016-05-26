//
//  TeacherLessonTableViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

// class for showing the tableview in which the past lessons are
class TeacherPastLessonTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var parentController: TeacherMainViewController?
    
    var managedObjectContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let appDelegate = CoreDataHandler.sharedInstance.appDelegate//UIApplication.sharedApplication().delegate as! AppDelegate
        
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        
        let predicate = NSPredicate(format: "ANY teacherRelationship.teacherName == %@ AND lessonStarted == %@", argumentArray: [(CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as? String)!, "yes"])
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
    
    
    override func viewDidLoad() {
        tableView.layer.borderWidth = 0.8
        let metropoliaColor = UIColor(red: 238.0/255.0, green: 103.0/255.0, blue: 7.0/255.0, alpha: 1)
        tableView.layer.borderColor = metropoliaColor.CGColor
        tableView.layer.cornerRadius = 5
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
        
        self.refreshControl?.addTarget(self, action: #selector(TeacherPastLessonTableViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        super.viewDidLoad()
        title = "\"List of all Lessons\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numberOfSections = 1
        if let sections = fetchedResultsController.sections {
            numberOfSections = sections.count
        }
        return numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("func tableView return cell")
        let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
 
        let p = fetchedResultsController.objectAtIndexPath(indexPath)
        
        cell!.textLabel!.text =
            p.valueForKey("lessonName") as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(parentController)
        self.parentController!.performSegueWithIdentifier("TeacherFeedbackPushSegue", sender: parentController)
        
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        let p = fetchedResultsController.objectAtIndexPath(indexPath)
        let g = p.valueForKey("lessonRatingAverage") as? String
        
        if(g != nil){
            CoreDataHandler.sharedInstance.zetCurrentRatingAvg("Rating for this lesson: \(g!)")
        }
        else {
            CoreDataHandler.sharedInstance.zetCurrentRatingAvg("No rating for this lesson")
        }
        
        CoreDataHandler.sharedInstance.zetCurrentLesson(currentCell.textLabel!.text!)
        CoreDataHandler.sharedInstance.getLessonsTopics(currentCell.textLabel!.text!)
        CoreDataHandler.sharedInstance.getLessonsFeedbacks(currentCell.textLabel!.text!)
        
        
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

