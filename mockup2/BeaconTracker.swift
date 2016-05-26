//
//  BeaconTracker.swift
//  mockup2
//
//  Created by Mortti Aittokoski on 20.5.2016.
//  Copyright © 2016 Mortti Aittokoski. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconTracker: NSObject, CLLocationManagerDelegate{
    static let sharedInstance = BeaconTracker()
    var currentRoom:String = ""
    
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "00000000-0000-0000-0000-000000000000")!, identifier: "ibks 105")
    
    func startScanning(){
        
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
            if(closestBeacon.major == 6666){
                currentRoom = "303"
            }
            if(closestBeacon.major == 23){
                currentRoom = "304"
            }
            else{
                currentRoom = "303"
            }
        }
    }
}