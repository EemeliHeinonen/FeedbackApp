//
//  StudentTopicsTableController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 1.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class StudentTopicsTableController: UITableViewController {
    var parentController: StudentLessonViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"List of topics in one lesson\""
        //tableView.registerClass(StudentTopicsTableController.self, forCellReuseIdentifier: "Cell")
        
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
        
        let cellIdentifier = "StudentTopicsTableCellController" //needed for cell class
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! StudentTopicsTableCellController // needed for cell class
        
        let p = CoreDataHandler.sharedInstance.lessonsTopics[indexPath.row]
        
        /*cell!.textLabel!.text =
            p.valueForKey("topicName") as? String*/
        
        cell.topicLabel.text = p.valueForKey("topicName") as? String
        
        return cell
    }

}