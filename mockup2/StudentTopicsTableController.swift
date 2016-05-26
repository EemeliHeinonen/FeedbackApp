//
//  StudentTopicsTableController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 1.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

// class for students ongoing lessons tableview showing the topics
class StudentTopicsTableController: UITableViewController {
    var parentController: StudentLessonViewController?

    override func viewDidLoad() {
        
        tableView.layer.borderWidth = 0.8
        let metropoliaColor = UIColor(red: 238.0/255.0, green: 103.0/255.0, blue: 7.0/255.0, alpha: 1)
        tableView.layer.borderColor = metropoliaColor.CGColor
        tableView.layer.cornerRadius = 5
        
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
        
        let cellIdentifier = "StudentTopicsTableCellController" //needed for cell class
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StudentTopicsTableCellController // needed for cell class
        
        let p = CoreDataHandler.sharedInstance.lessonsTopics[indexPath.row]
        
        cell.topicLabel.text = p.valueForKey("topicName") as? String
        
        return cell
    }

}