//
//  TeacherLessonViewController2.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 18.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

// class for the teachers current lesson view for ongoig lesson
class TeacherLessonViewController2: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "teacherTopicContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! TeacherTopicsTableController
            destinationCtrl.parentController = self
        }
    }
}

