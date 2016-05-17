//
//  LaunchScreenViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 16.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import Foundation
import UIKit

class LaunchScreenViewController: UIViewController{
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        if(CoreDataHandler.sharedInstance.me.count == 0){
            
        }
        else{
            
        }
    }
}