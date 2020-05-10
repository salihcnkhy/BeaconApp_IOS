//
//  Devices.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import Foundation
import CoreLocation



struct Device : Identifiable {
    
    
    let id = UUID()
    var uuid : UUID
    var minor : Int
    var major : Int
    var name : String
    var isFound : Bool = false
    var far : Double = 0
init(uuid: UUID, minor: Int, major: Int, name: String) {
        self.uuid = uuid
        self.minor = minor
        self.major = major
        self.name = name
    }
    
    

    
   
}
