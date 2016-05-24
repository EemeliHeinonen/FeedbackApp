//
//  TeacherTopicsTableController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

class TeacherTopicsTableController: UITableViewController, NSFetchedResultsControllerDelegate {
    var parentController: TeacherLessonViewController2?
    var managedObjectContext: NSManagedObjectContext!
    var zuubaduu = [NSManagedObject]()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        // Initialize Fetch Request
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let fetchRequest = NSFetchRequest(entityName: "Topic")
        
        let predicate = NSPredicate(format: "%K == %@", "lessonRelationship.lessonName", CoreDataHandler.sharedInstance.getCurrentLesson())
        fetchRequest.predicate = predicate
        
        
        // Add Sort Descriptors
        let sortDescriptor = NSSortDescriptor(key: "topicName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Initialize Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

        
    override func viewDidLoad() {
        print("teachertopicstablecontorller view did load BAZINGGAAAAAAAAAAAAAAA ASD ")
        super.viewDidLoad()
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print ("Could not fetch \(error), \(error.userInfo)")
        }
      
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numberOfSections = 1
        if let sections = fetchedResultsController.sections {
            numberOfSections = sections.count
        }
        return numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("func tableView return count")
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("func tableView return cell")
        
        let cellIdentifier = "TeacherTopicsTableCellController" //needed for cell class
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TeacherTopicsTableCellController // needed for cell class
        
        let p = fetchedResultsController.objectAtIndexPath(indexPath)
        
        /*cell!.textLabel!.text =
         p.valueForKey("topicName") as? String*/
        
        cell.topicNameLabel.text = p.valueForKey("topicName") as? String
        cell.gotItLabel.text =  NetworkOperations.sharedInstance.getGotItValues("lesson", topic: (p.valueForKey("topicName") as? String)!) //p.valueForKey("gotItRating") as? String
        cell.didntGetItLabel.text = p.valueForKey("notGotItRating") as? String
        
        return cell
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!did change content")
        self.tableView.reloadData()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {

        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    
}
