//
//  TeacherTopicsTableCellController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

// clas for the cell of TeacherRatingsTableController
class TeacherRatingsTableCellController: UITableViewCell{
    
    @IBOutlet weak var rating: UILabel!

    @IBOutlet weak var feedbackTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
