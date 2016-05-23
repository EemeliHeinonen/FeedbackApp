//
//  TeacherTopicsTableController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class TeacherFeedbackTopicsTableViewController: UITableViewController {
    var parentController: TeacherFeedbackViewController?
    
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
        
        let cellIdentifier = "TeacherFeedbackTopicsTableCell" //needed for cell class
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TeacherFeedbackTopicsTableCell // needed for cell class
        
        let p = CoreDataHandler.sharedInstance.lessonsTopics[indexPath.row]
        
        /*cell!.textLabel!.text =
         p.valueForKey("topicName") as? String*/
       
        cell.topic.text = p.valueForKey("topicName") as? String
        cell.gotIt.text = p.valueForKey("gotItRating") as? String
        cell.notGotIt.text = p.valueForKey("notGotItRating") as? String
        
        return cell
    }
    
}
