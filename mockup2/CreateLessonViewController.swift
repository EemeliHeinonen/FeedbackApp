//
//  CreateLessonViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 12.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreData

class CreateLessonViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var lessonName: UITextField!
    @IBOutlet weak var classroom: UITextField!
    @IBOutlet weak var time: UITextField!
    @IBOutlet weak var topic1: UITextField!
    @IBOutlet weak var topic2: UITextField!
    @IBOutlet weak var topic3: UITextField!
    
     var managedObjectContext: NSManagedObjectContext!
    
    @IBAction func doneAction(sender: AnyObject) {
        print("done")
        print("done editing")
        print(lessonName.text)
        print(time.text)
        print(classroom.text)
        print(CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as! String)
        
        print("post lesson")
        NetworkOperations.sharedInstance.postLesson(lessonName.text!, time: time.text!)
        print("post teacher")
        print("sleep alkaa")
        NSThread.sleepForTimeInterval(1)
        print("sleep loppuu")
        NetworkOperations.sharedInstance.postTeacher(lessonName.text!, t: CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as! String)

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
        
       // NetworkOperations.sharedInstance.getLessonsByTeacher(CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as! String)
        NetworkOperations.sharedInstance.postClassroom(lessonName.text!, room: classroom.text!)
        NSThread.sleepForTimeInterval(1)

        clearLessonsEntity()
        //getlessonsbyTeacher()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*subject.delegate = self
        time.delegate = self
        
 */
        topic3.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return painettu")
        textField.resignFirstResponder()
      
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("textfielld did begin editing")
    }
    
    func clearLessonsEntity(){
        let appDelegate =
            CoreDataHandler.sharedInstance.appDelegate//UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = CoreDataHandler.sharedInstance.managedContext//appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext!.executeRequest(deleteRequest)
            try managedContext!.save()
            
            print("clearattu lesson entity")
        } catch let error as NSError {
            // TODO: handle the error
        }
        getlessonsbyTeacher()
    }
    func getlessonsbyTeacher(){
        NetworkOperations.sharedInstance.getLessonsByTeacher((CoreDataHandler.sharedInstance.me.last?.valueForKey("myName") as? String)!)
    }

    
}