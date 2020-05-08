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
        
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    private func createBeaconRegion(from deviceList : [Device]) -> [CLBeaconRegion]{
        var region = [CLBeaconRegion]()
        for device in deviceList {
            region.append(CLBeaconRegion(uuid: UUID(uuidString: device.uuid)!, major: .init(device.major), minor: .init(device.minor), identifier: device.name))
        }
        return region
    }
    
    public func StartSearching(all deviceList : [Device]){
        
        let beaconRegion = createBeaconRegion(from: deviceList)
        
              if checkManagerAvailable() {
                for beacon in beaconRegion{
                    locationManager.startMonitoring(for: beacon)
                    locationManager.startRangingBeacons(satisfying: beacon.beaconIdentityConstraint)
                }
              }else{
              GetPermission()
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
        
        NotificationCenter.default.post(name: .beaconFound , object: beacons)

    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
    }
    
    
    
    
}
extension Notification.Name {
    static let beaconFound = Notification.Name(rawValue: "BeaconsFound")
}
