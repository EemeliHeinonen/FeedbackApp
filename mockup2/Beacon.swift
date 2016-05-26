//
//  Beacon.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 11.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class Beacon: UIViewController{
    
    override func viewDidLoad() {
       // self.navigationItem.hidesBackButton = true
        //self.navigationItem.leftBarButtonItem = nil
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
       
    }
}