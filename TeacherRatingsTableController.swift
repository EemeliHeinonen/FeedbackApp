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
        tableView.layer.borderWidth = 0.8
        let metropoliaColor = UIColor(red: 238.0/255.0, green: 103.0/255.0, blue: 7.0/255.0, alpha: 1)
        tableView.layer.borderColor = metropoliaColor.CGColor
        tableView.layer.cornerRadius = 5
        super.viewDidLoad()
        
        print("TeecherFeedbackViewController didload")
        
        
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
        
        print(" =)=)=)))=)=)=)=)=)=)=)=)=)=)=)=)=)=)==)== \(CoreDataHandler.sharedInstance.feedbacks.count)")
        let p = CoreDataHandler.sharedInstance.feedbacks[indexPath.row]
        
        /*cell!.textLabel!.text =
         p.valueForKey("topicName") as? String*/
        
        
        
        cell.rating.text = p.valueForKey("lessonRating") as? String
        cell.feedbackTextLabel.text = p.valueForKey("feedbackText") as? String
        

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        let nakki = CoreDataHandler.sharedInstance.feedbacks[indexPath.row]
        parentController!.performSegueWithIdentifier("FeedbackTextPushSegue", sender: parentController)
        
        if (nakki.valueForKey("lessonRating") != nil){
            CoreDataHandler.sharedInstance.zetCurrentLessonRating((nakki.valueForKey("lessonRating") as? String)!)
        }
        else {
            CoreDataHandler.sharedInstance.zetCurrentLessonRating("")
        }
        
        if(nakki.valueForKey("feedbackText") != nil){
            CoreDataHandler.sharedInstance.zetCurrentFeedbackText((nakki.valueForKey("feedbackText") as? String)!)
        }
        else {
            CoreDataHandler.sharedInstance.zetCurrentFeedbackText("")
        }
        
        
}
}
