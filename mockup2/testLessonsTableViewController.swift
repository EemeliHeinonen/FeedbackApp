//
//  testLessonsTableViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 28.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class testLessonsTableViewController: UITableViewController {
    var parentController: StudentMainViewViewController?
    override func viewDidLoad() {
        print("lessontableviewcontroller viewdidload")
        super.viewDidLoad()
        title = "\"List of all Lessons\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("func lessonntableView return count")
        print( CoreDataHandler.sharedInstance.lessons.count)

        return CoreDataHandler.sharedInstance.lessons.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("func tableView return cell")
        let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let p = CoreDataHandler.sharedInstance.lessons[indexPath.row]
        
        cell!.textLabel!.text =
            p.valueForKey("lessonName") as? String
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        parentController!.performSegueWithIdentifier("lessonSegue", sender: parentController)
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        let meCount = CoreDataHandler.sharedInstance.me.count-1
        CoreDataHandler.sharedInstance.getLessonsTopics(currentCell.textLabel!.text!)
        CoreDataHandler.sharedInstance.zetCurrentLesson(currentCell.textLabel!.text!)
        NetworkOperations.sharedInstance.postStuff(currentCell.textLabel!.text!, s: (CoreDataHandler.sharedInstance.me[meCount].valueForKey("myName") as? String)!)
        print(currentCell.textLabel!.text)
    }
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
