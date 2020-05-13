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
    
    private var notificationName : Notification.Name?
        
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        GetPermission()

    }
    private func createBeaconRegion(from deviceList : [Device]) -> [CLBeaconRegion]{
        var region = [CLBeaconRegion]()
        for device in deviceList {
            region.append(CLBeaconRegion(uuid: device.uuid, major: .init(device.major), minor: .init(device.minor), identifier: device.name))
        }
        return region
    }
    
    public func StartSearching(all deviceList : [Device],notificationName name : Notification.Name){
        
        self.notificationName = name
        let beaconRegion = createBeaconRegion(from: deviceList)
              if checkManagerAvailable() {
                for beacon in beaconRegion{
                    locationManager.startMonitoring(for: beacon)
                    locationManager.startRangingBeacons(satisfying: beacon.beaconIdentityConstraint)
                }
              }
      }
    
    public func StopSearching(all deviceList : [Device]){
        
        let beaconRegion = createBeaconRegion(from: deviceList)

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
        NotificationCenter.default.post(name: self.notificationName! , object: beacons)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("region enter")
        
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("region exit")

    }
    
    
    
    
}
extension Notification.Name {
    static let beaconsFound = Notification.Name(rawValue: "BeaconsFound")
    static let beaconFound = Notification.Name(rawValue: "BeaconFound")
}
