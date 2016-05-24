//
//  TeacherFeedbackTextViewController.swift
//  mockup2
//
//  Created by Eemeli Heinonen on 23/05/16.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit


class TeacherFeedbackTextViewController: UIViewController{
    @IBOutlet weak var feedbackViewRatingLabel: UILabel!
    
    @IBOutlet weak var feedbackViewTextLabelLong: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        print(CoreDataHandler.sharedInstance.getCurrentLessonRating())
        print(CoreDataHandler.sharedInstance.getCurrentFeedbackText())
        if (CoreDataHandler.sharedInstance.getCurrentLessonRating() == ""){
            feedbackViewRatingLabel.text = "No rating"
        }
        else {
        feedbackViewRatingLabel.text = CoreDataHandler.sharedInstance.getCurrentLessonRating()
        }
        if (CoreDataHandler.sharedInstance.getCurrentFeedbackText() == ""){
            feedbackViewTextLabelLong.text = "No feedback given"
        }
        else{
        feedbackViewTextLabelLong.text = CoreDataHandler.sharedInstance.getCurrentFeedbackText()
        }
    }
}
