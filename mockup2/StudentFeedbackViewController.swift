//
//  ViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import QuartzCore

// class for students feedback for past lessons
class StudentFeedbackViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UINavigationControllerDelegate {
    
  
    @IBOutlet weak var lessonRatingSegment: UISegmentedControl!
    
    @IBOutlet weak var feedbackTextViewOutlet: UITextView!
    var selectedRating = ""
    
    @IBAction func ratingValueChangedAction(sender: UISegmentedControl) {
        
        switch lessonRatingSegment.selectedSegmentIndex {
        case 0:
            print("arvosana 1")
            selectedRating = "1"
        case 1:
            print("arvosana 2")
            selectedRating = "2"
        case 2:
            print("arvosana 3")
            selectedRating = "3"
        case 3:
            print("arvosana 4")
            selectedRating = "4"
        default:
            break
        }
    }

    @IBAction func submitFeedbackAction(sender: UIBarButtonItem) {
        NetworkOperations.sharedInstance.postFeedback(CoreDataHandler.sharedInstance.getCurrentLesson(), f: feedbackTextViewOutlet.text!, rating: selectedRating)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackTextViewOutlet.layer.cornerRadius = 5
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "StudentFeedbackTopicsContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! StudentFeedbackTopicsTableViewController
            destinationCtrl.parentController = self
        }
    }
}

