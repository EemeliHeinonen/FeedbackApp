//
//  CreateLessonViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 12.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

//class for creating a new lesson
class CreateLessonViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var lessonName: UITextField!
    @IBOutlet weak var classroom: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var topic1: UITextField!
    @IBOutlet weak var topic2: UITextField!
    @IBOutlet weak var topic3: UITextField!
    
     var managedObjectContext: NSManagedObjectContext!
    
    @IBAction func doneAction(sender: AnyObject) {
      
        NetworkOperations.sharedInstance.postLesson(lessonName.text!, time: time.text!)
        NSThread.sleepForTimeInterval(1)
        NetworkOperations.sharedInstance.postTeacher(lessonName.text!, t: CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as! String)
        NetworkOperations.sharedInstance.postClassroom(lessonName.text!, classroom: classroom.text!)

        if(topic1.text != ""){
            print("post topic1")
            print(topic1.text!)
            NetworkOperations.sharedInstance.postTopic(lessonName.text!, t: topic1.text!)
        }
        if(topic2.text != ""){
            print("post topic2")
            print(topic2.text!)
            NetworkOperations.sharedInstance.postTopic(lessonName.text!, t: topic2.text!)
        }
        if(topic3.text != ""){
            print("post topic3")
            print(topic3.text!)
            NetworkOperations.sharedInstance.postTopic(lessonName.text!, t: topic3.text!)
        }
        

        NSThread.sleepForTimeInterval(1)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        topic3.delegate = self
    }
  
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("textfielld did begin editing")
    }
    
}