//
//  Device.swift
//  WirelessNetworks
//
//  Created by Gülnur Kasarcı on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import Foundation

struct Device : Identifiable {
    
     let id = UUID()
     var name : String
     var far : Double
     var batteryLevel : Int
    
    init(name : String , far : Double , batteryLevel : Int) {
        
        self.name = name
        self.far = far
        self.batteryLevel = batteryLevel
        
    }
}
