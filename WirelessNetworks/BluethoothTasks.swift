//
//  BluethoothTasks.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 5.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation
import SwiftUI


class BluetoothTasks : NSObject ,ObservableObject , CLLocationManagerDelegate{
    
    public static let shared = BluetoothTasks()
    
    
    private var locationManager = CLLocationManager()
    
    private var AuthStatus : CLAuthorizationStatus!
    
    private var foundBeaconList : [Device] = []
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func StartSearching(all beaconRegion : [CLBeaconRegion]) -> Bool{
        
              if checkManagerAvailable() {
                for beacon in beaconRegion{
                    print("Seaching")
                    locationManager.startMonitoring(for: beacon)
                    locationManager.startRangingBeacons(satisfying: beacon.beaconIdentityConstraint)
                }
                return true
              }else{
              GetPermission()
            return false
          }
          
      }
    public func StopSearching(all beaconRegion : [CLBeaconRegion]){
        for beacon in beaconRegion{
            locationManager.stopMonitoring(for: beacon)
            locationManager.stopRangingBeacons(satisfying: beacon.beaconIdentityConstraint)
        }
    }

    public func GetPermission(){
        if AuthStatus != .authorizedAlways {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
  
    private func checkManagerAvailable() -> Bool{
        return CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) && CLLocationManager.isRangingAvailable()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.AuthStatus = status
        
    }
     
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        print("---DidRange---")
        print(beacons)
        foundBeaconList.removeAll(keepingCapacity: false)
        for beacon in beacons {
            foundBeaconList.append(UnknownDevice(beacon: beacon, name: beacon.description, far: beacon.accuracy.magnitude, uuid: beacon.uuid.uuidString, batteryLevel: 100, aproximity: .far))
        }
         
        NotificationCenter.default.post(name: .beaconChanges , object: foundBeaconList)

        print("--------------\n")

    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
    }
    
    
    
    
}
extension Notification.Name {
    static let beaconChanges = Notification.Name(rawValue: "BeaconChanges")
}
