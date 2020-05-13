//
//  Devices.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI
import UserNotifications

struct Device : Identifiable {
    
    let id = UUID()
    var uuid : UUID
    var minor : Int
    var major : Int
    var name : String
    var sendNotification : Bool = false {
        didSet{
            if self.sendNotification {
                let state = UIApplication.shared.applicationState
                if state == .background{
                    let center = UNUserNotificationCenter.current()
                       let content = UNMutableNotificationContent()
                       content.title = "You are so far from your device"
                    content.body = "You are no longer connected to your device that named \(self.name)"
                       content.categoryIdentifier = "Warning"
                       content.sound = UNNotificationSound.default
                       let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
                       center.add(request)
                }
            self.sendNotification = false
            }
        }
    }
    var isFound : Bool = false
    var far : Double = 0
    var rssi : Int = 0 {
        didSet{
            if self.rssi == 0 {
                self.sendNotification = true
                self.far = 0
                self.isFound = false
            }
        }
    }
    init(uuid: UUID, minor: Int, major: Int, name: String) {
        self.uuid = uuid
        self.minor = minor
        self.major = major
        self.name = name
    }
}

class Devices : ObservableObject {
    
    @Published var allDevices : [Device]
    
    init() {
        print("Devices Created")
        self.allDevices = [Device(uuid: UUID(uuidString: "59F9F7D1-86DB-4198-A623-130E931DF45B")!, minor: 0, major: 100, name: "Beacon")]
    }
    
}


