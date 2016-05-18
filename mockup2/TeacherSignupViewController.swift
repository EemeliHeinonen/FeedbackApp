//
//  TeacherSignupViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit


class TeacherSignupViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var teacherNameOutlet: UITextField!
    
    @IBAction func clearEntityButton(sender: AnyObject) {
        CoreDataHandler.sharedInstance.clearLessonEntity()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Teacher signup view loaded")
        teacherNameOutlet.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return painettu")
        textField.resignFirstResponder()
        print("done editing")
        CoreDataHandler.sharedInstance.saveMyName(teacherNameOutlet.text!, type: "teacher")
        print("Teacher name saved \(teacherNameOutlet.text)")
        
        return true
    }
    
    // OIS OIKEEN KIVA JOS JOSKUS SAAATAIS TÄÄ TOIMIMAAN xdddd
    /*
     @IBAction func submitAction(sender: AnyObject) {
     teacherNameOutlet.resignFirstResponder()
     CoreDataHandler.sharedInstance.saveStudentName(teacherNameOutlet.text!)
     print("Student name saved \(teacherNameOutlet.text)")
     }
     */
}

