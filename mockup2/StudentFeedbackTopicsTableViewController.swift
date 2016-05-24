//
//  StudentFeedbackTopicsTableViewController.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 24/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//
import UIKit

class StudentFeedbackTopicsTableViewController: UITableViewController {
    var parentController: StudentFeedbackViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("func tableView return count")
        return CoreDataHandler.sharedInstance.lessonsTopics.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("func tableView return cell")
        
        let cellIdentifier = "StudentFeedbackTopicsTableCell" //needed for cell class
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StudentFeedbackTopicsTableCell // needed for cell class
        
        let p = CoreDataHandler.sharedInstance.lessonsTopics[indexPath.row]

        
        cell.studentFeedbackTopicNameLabel.text = p.valueForKey("topicName") as? String
        
        return cell
    }

}