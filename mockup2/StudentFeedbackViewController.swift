//
//  ViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit


class StudentFeedbackViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var feedbackTextViewBox: UITextField!
    @IBOutlet weak var lessonRatingSegment: UISegmentedControl!
    
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
        NetworkOperations.sharedInstance.postFeedback(CoreDataHandler.sharedInstance.getCurrentLesson(), f: feedbackTextViewBox.text!, rating: selectedRating)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "StudentFeedbackTopicsContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! StudentFeedbackTopicsTableViewController
            //print(self)
            destinationCtrl.parentController = self
        }
    }
}

