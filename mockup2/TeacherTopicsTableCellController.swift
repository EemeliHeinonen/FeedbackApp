//
//  TeacherTopicsTableCellController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class TeacherTopicsTableCellController: UITableViewCell{
    
    @IBOutlet weak var didntGetItLabel: UILabel!
    @IBOutlet weak var gotItLabel: UILabel!
    @IBOutlet weak var topicNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
