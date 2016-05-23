//
//  TeacherFeedbackTextViewController.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 23/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit


class TeacherFeedbackTextViewController: UIViewController{
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var feedbackTextLabelLong: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        rating.text = CoreDataHandler.sharedInstance.getCurrentLessonRating()
        feedbackTextLabelLong.text = CoreDataHandler.sharedInstance.getCurrentFeedbackText()
    }
}
