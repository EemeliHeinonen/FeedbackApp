//
//  TeacherSignupViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

//class for teachers sign up viewcontroller
class TeacherSignupViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var teacherNameOutlet: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        print("Teacher signup view loaded")
        teacherNameOutlet.delegate = self
        teacherNameOutlet.layer.borderWidth = 0.8
        let metropoliaColor = UIColor(red: 238.0/255.0, green: 103.0/255.0, blue: 7.0/255.0, alpha: 1)
        teacherNameOutlet.layer.borderColor = metropoliaColor.CGColor
        teacherNameOutlet.layer.cornerRadius = 5
        
    }
    
    override func viewWillAppear(animated: Bool) {
        teacherNameOutlet.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return painettu")
        textField.resignFirstResponder()
        print("done editing")
        CoreDataHandler.sharedInstance.saveMyName(teacherNameOutlet.text!, type: "teacher")
        print("Teacher name saved \(teacherNameOutlet.text)")
        
        self.navigationItem.rightBarButtonItem?.enabled = true
        
        return true
    }

}