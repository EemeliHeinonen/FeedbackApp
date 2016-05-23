//
//  TeacherFeedbackTopicsTableCell.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 23/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class TeacherFeedbackTopicsTableCell: UITableViewCell{

    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var gotIt: UILabel!
    @IBOutlet weak var notGotIt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
