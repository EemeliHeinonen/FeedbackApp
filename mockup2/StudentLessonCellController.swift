//
//  StudentLessonCellController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 29.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class StudentLessonCellController: UITableViewCell{
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBAction func gotIt(sender: UIButton) {
        //NetworkOperations.sharedInstance.gotIt(<#T##course: String##String#>, topic: <#T##String#>)
    }
    
    @IBAction func didntGotIt(sender: UIButton) {
        //NetworkOperations.sharedInstance.notGotIt(<#T##course: String##String#>, topic: <#T##String#>)
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
