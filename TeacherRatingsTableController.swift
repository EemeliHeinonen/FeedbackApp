//
//  TeacherRatingsTableController.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 21/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

// class for tablview showing the after-lesson feedback given by students
class TeacherRatingsTableController: UITableViewController {
    var parentController: TeacherFeedbackViewController?
    
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
        return CoreDataHandler.sharedInstance.feedbacks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TeacherRatingsTableCellController" //needed for cell class
        let cell =
            tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TeacherRatingsTableCellController // needed for cell class
        let p = CoreDataHandler.sharedInstance.feedbacks[indexPath.row]
        cell.rating.text = p.valueForKey("lessonRating") as? String
        cell.feedbackTextLabel.text = p.valueForKey("feedbackText") as? String
        

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        let feedbackIndex = CoreDataHandler.sharedInstance.feedbacks[indexPath.row]
        parentController!.performSegueWithIdentifier("FeedbackTextPushSegue", sender: parentController)
        
        if (feedbackIndex.valueForKey("lessonRating") != nil){
            CoreDataHandler.sharedInstance.zetCurrentLessonRating((feedbackIndex.valueForKey("lessonRating") as? String)!)
        }
        else {
            CoreDataHandler.sharedInstance.zetCurrentLessonRating("")
        }
        
        if(feedbackIndex.valueForKey("feedbackText") != nil){
            CoreDataHandler.sharedInstance.zetCurrentFeedbackText((feedbackIndex.valueForKey("feedbackText") as? String)!)
        }
        else {
            CoreDataHandler.sharedInstance.zetCurrentFeedbackText("")
        }  
    }
}
