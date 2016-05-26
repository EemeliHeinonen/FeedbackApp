//
//  StudentFeedbackTopicsTableViewController.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 24/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//
import UIKit
import QuartzCore

class StudentFeedbackTopicsTableViewController: UITableViewController {
    var parentController: StudentFeedbackViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.borderWidth = 0.8
        var metropoliaColor = UIColor(red: 238.0/255.0, green: 103.0/255.0, blue: 7.0/255.0, alpha: 1)
        tableView.layer.borderColor = metropoliaColor.CGColor
        tableView.layer.cornerRadius = 5

        
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