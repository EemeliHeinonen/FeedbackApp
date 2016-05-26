//
//  testLessonsTableViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 28.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

class testLessonsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var parentController: StudentMainViewViewController?
    var managedObjectContext: NSManagedObjectContext!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        
        
        let predicate = NSPredicate(format: "%K == %@", "classroomRelationship.roomName", BeaconTracker.sharedInstance.currentRoom)
        fetchRequest.predicate = predicate
        
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
        print("currentRoom:::::")
        print(BeaconTracker.sharedInstance.currentRoom)
        tableView.layer.borderWidth = 0.8
        var metropoliaColor = UIColor(red: 238.0/255.0, green: 103.0/255.0, blue: 7.0/255.0, alpha: 1)
        tableView.layer.borderColor = metropoliaColor.CGColor
        tableView.layer.cornerRadius = 5
        
        clearLessonsEntity()
        print("lessontableviewcontroller viewdidload")
        super.viewDidLoad()
        title = "\"List of all Lessons\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func getLessons(){
        NetworkOperations.sharedInstance.getLessons()
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
        getLessons()
 
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
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
        print("nyt tulee parentcontrollerprintti")
        print(parentController)
        parentController!.performSegueWithIdentifier("lessonSegue", sender: parentController)
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        let meCount = CoreDataHandler.sharedInstance.me.count-1
        CoreDataHandler.sharedInstance.getLessonsTopics(currentCell.textLabel!.text!)
        CoreDataHandler.sharedInstance.zetCurrentLesson(currentCell.textLabel!.text!)
        NetworkOperations.sharedInstance.postStudent(currentCell.textLabel!.text!, s: (CoreDataHandler.sharedInstance.me[meCount].valueForKey("myName") as? String)!)
        print(currentCell.textLabel!.text)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!did change content")
        self.tableView.reloadData()
    }
    
}
