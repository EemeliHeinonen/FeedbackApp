//
//  StudentSignupViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit


class StudentSignupViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var studentNameOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("student signup view loaded")
        studentNameOutlet.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return painettu")
        textField.resignFirstResponder()
        print("done editing")
        CoreDataHandler.sharedInstance.saveStudentName(studentNameOutlet.text!)
        print("Student name saved \(studentNameOutlet.text)")
        
        return true
    }
 
    // OIS OIKEEN KIVA JOS JOSKUS SAAATAIS TÄÄ TOIMIMAAN xdddd
    /*
    @IBAction func submitAction(sender: AnyObject) {
        studentNameOutlet.resignFirstResponder()
        CoreDataHandler.sharedInstance.saveStudentName(studentNameOutlet.text!)
        print("Student name saved \(studentNameOutlet.text)")
    }
 */
}

