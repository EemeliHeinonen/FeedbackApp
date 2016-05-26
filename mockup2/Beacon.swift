//
//  Beacon.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 11.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

//Viewcontroller for the welcome screen
class Beacon: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
       
    }
}