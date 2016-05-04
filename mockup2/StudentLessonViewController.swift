//
//  StudentLessonViewController.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 21.3.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit

class StudentLessonViewController: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "topicContainerSegue"){
            let destinationCtrl = segue.destinationViewController as! StudentTopicsTableController
            destinationCtrl.parentController = self
        }
    }
    
    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }*/
    //okei vittu tää table paska pitäs olla omas tableviewvontrollerisa ja sit containeriin asadsdsaaddas
    
}

