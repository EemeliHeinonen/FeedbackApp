//
//  StudentTopicsTableCellController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 1.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class StudentTopicsTableCellController: UITableViewCell{
    
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBAction func gotItAction(sender: AnyObject) {
    }
    
    @IBAction func didNotGetIt(sender: AnyObject) {
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