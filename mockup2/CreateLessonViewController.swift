//
//  CreateLessonViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 12.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class CreateLessonViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var classroom: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var topic1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subject.delegate = self
        time.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return painettu")
        textField.resignFirstResponder()
        print("done editing")
        NetworkOperations.sharedInstance.postLesson(subject.text!, time: time.text!)
        
        return true
    }
    
}

// KUKOKUOKU
// Changes made.