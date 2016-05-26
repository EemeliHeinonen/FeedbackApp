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
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        print("student signup view loaded")
        studentNameOutlet.delegate = self
        
        studentNameOutlet.layer.borderWidth = 0.8
        let metropoliaColor = UIColor(red: 238.0/255.0, green: 103.0/255.0, blue: 7.0/255.0, alpha: 1)
        studentNameOutlet.layer.borderColor = metropoliaColor.CGColor
        studentNameOutlet.layer.cornerRadius = 5
        
    }
    @IBAction func submitActionBarButton(sender: UIBarButtonItem) {
        
    }
    override func viewWillAppear(animated: Bool) {
        studentNameOutlet.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return painettu")
        textField.resignFirstResponder()
        print("done editing")
        CoreDataHandler.sharedInstance.saveMyName(studentNameOutlet.text!, type: "student")
        print("Student name saved \(studentNameOutlet.text)")
        
        self.navigationItem.rightBarButtonItem?.enabled = true
        
        
        return true
    }
}

