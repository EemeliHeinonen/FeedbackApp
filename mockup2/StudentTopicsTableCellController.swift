//
//  StudentTopicsTableCellController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 1.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

// class for the cell of StudentTopicsTableController
class StudentTopicsTableCellController: UITableViewCell{
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBAction func StudentTopicsTableCellSegmentAction(sender: UISegmentedControl) {
        
        switch StudentTopicsTableCellGotItSegment.selectedSegmentIndex {
        case 0:
            print("Got it")
            NetworkOperations.sharedInstance.gotIt(CoreDataHandler.sharedInstance.getCurrentLesson(), topic: topicLabel.text!)
        case 1:
            print("Didn't get it")
            NetworkOperations.sharedInstance.notGotIt(CoreDataHandler.sharedInstance.getCurrentLesson(), topic: topicLabel.text!)
        default:
            break
        }
    }
    @IBOutlet weak var StudentTopicsTableCellGotItSegment: UISegmentedControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
