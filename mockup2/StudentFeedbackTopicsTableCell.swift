//
//  StudentFeedbackTopicsTableCell.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 24/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class StudentFeedbackTopicsTableCell: UITableViewCell{
    
    @IBOutlet weak var studentFeedbackTopicNameLabel: UILabel!
    
    @IBOutlet weak var StudentFeedbackTopicGotItSegmentOutlet: UISegmentedControl!
   
    @IBAction func StudentFeedbackTopicGotItSegmentAction(sender: UISegmentedControl) {
        switch StudentFeedbackTopicGotItSegmentOutlet.selectedSegmentIndex {
        case 0:
            print("Got it")
            NetworkOperations.sharedInstance.gotIt(CoreDataHandler.sharedInstance.getCurrentLesson(), topic: studentFeedbackTopicNameLabel.text!)
        case 1:
            print("Didn't get it")
            NetworkOperations.sharedInstance.notGotIt(CoreDataHandler.sharedInstance.getCurrentLesson(), topic: studentFeedbackTopicNameLabel.text!)
        default:
            break
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}