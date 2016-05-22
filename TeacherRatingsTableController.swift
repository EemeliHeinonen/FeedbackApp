//
//  TeacherRatingsTableController.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 21/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class TeacherRatingsTableController: UITableViewController {
    var parentController: TeacherFeedbackViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("func tableView return count")
        return CoreDataHandler.sharedInstance.feedbacks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("func tableView return cell")
        
        let cellIdentifier = "TeacherRatingsTableCellController" //needed for cell class
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TeacherRatingsTableCellController // needed for cell class
        
        let p = CoreDataHandler.sharedInstance.feedbacks[indexPath.row]
        
        /*cell!.textLabel!.text =
         p.valueForKey("topicName") as? String*/
        
        cell.ratingLabel.text = p.valueForKey("lessonRating") as? String
        cell.feedbackTextLabel.text = p.valueForKey("feedbackText") as? String
        
        return cell
    }
    
}
