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
    }
    
    @IBAction func didntGotIt(sender: UIButton) {
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
