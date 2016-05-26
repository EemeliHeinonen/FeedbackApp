//
//  StudentLessonViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

// class for students ongoing lesson viewcontroller
class StudentLessonViewController: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "topicContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! StudentTopicsTableController
            destinationCtrl.parentController = self
        }
    }
    
}

