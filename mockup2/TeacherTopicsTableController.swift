//
//  TeacherTopicsTableController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class TeacherTopicsTableController: UITableViewController {
    var parentController: TeacherLessonViewController2?
        
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
        
        let cellIdentifier = "TeacherTopicsTableCellController" //needed for cell class
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TeacherTopicsTableCellController // needed for cell class
        
        let p = CoreDataHandler.sharedInstance.lessonsTopics[indexPath.row]
        
        /*cell!.textLabel!.text =
         p.valueForKey("topicName") as? String*/
        
        cell.topicNameLabel.text = p.valueForKey("topicName") as? String
        
        return cell
    }
    
}
