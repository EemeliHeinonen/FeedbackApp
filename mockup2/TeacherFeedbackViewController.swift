//
//  TeacherFeedbackViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 15.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit


class TeacherFeedbackViewController: UIViewController{
    @IBOutlet weak var ratingAvgLabel: UILabel!
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "TeacherFeedbackTopicsTableContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! TeacherFeedbackTopicsTableViewController
            //print(self)
            destinationCtrl.parentController = self
        }
       if(segue.identifier == "TeacherRatingsTableContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! TeacherRatingsTableController
            //print(self)
            destinationCtrl.parentController = self
        }
        
        
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        ratingAvgLabel.text = CoreDataHandler.sharedInstance.getCurrentRatingAvg()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
