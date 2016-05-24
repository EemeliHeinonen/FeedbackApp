//
//  Beacon.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 11.4.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class Beacon: UIViewController, CLLocationManagerDelegate{
    
    var me = [NSManagedObject]()
    //MARK: Labels
    @IBOutlet weak var beaconCount: UILabel!
    
    @IBAction func printMeButton(sender: UIButton) {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        
        let fetchRequest = NSFetchRequest(entityName: "Me")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            me = results as! [NSManagedObject]
            print("ME Count Tulee täsä ny")
            print(me.count)

        }catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    static let sharedInstance = Beacon()

    @IBAction func clearName(sender: AnyObject) {
        CoreDataHandler.sharedInstance.clearMyName()
    }
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "00000000-0000-0000-0000-000000000000")!, identifier: "ibks 105")
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        //CoreDataHandler.sharedInstance.coreDataTestFunc() //crazy shit
        //CoreDataHandler.sharedInstance.getAllTopics()
        //CoreDataHandler.sharedInstance.getAllLessons()
        
        //NetworkOperations.sharedInstance.getStuff() //crazy shit
        //more of that
        //NetworkOperations.sharedInstance.getTopics() //omg...
                
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse){
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            //print(closestBeacon)
            beaconCount.text = "There are "+String(knownBeacons.count)+" beacon(s) nearby"
            if(closestBeacon.major == 60){
                //classroom = "303"
            }
            if(closestBeacon.major == 23){
                //classroom = "304"
            }
        }
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(CoreDataHandler.sharedInstance.me){
            
        }
    }
    */
    
}