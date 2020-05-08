//
//  Devices.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import Foundation
import CoreLocation


protocol Device {
     
    var id : UUID {get set}
    var name : String {get}
    var far : Double {get}
    var batteryLevel : Int {get}
    var aproximity : Aproximity {get set}
    var beacon : CLBeacon? { get set }
   
    
}


class KnownDevice : Device {
    
    var beacon: CLBeacon?

    var id: UUID = UUID()
    
    var name: String
    
    var far: Double
    
    var batteryLevel: Int
    
    var aproximity: Aproximity

    var inRange : Bool
    
    
    init(beacon: CLBeacon?, name: String, far: Double, batteryLevel: Int, aproximity: Aproximity, inRange: Bool) {
        self.beacon = beacon
        self.name = name
        self.far = far
        self.batteryLevel = batteryLevel
        self.aproximity = aproximity
        self.inRange = inRange
    }
    



    
}


struct UnknownDevice : Device {
    
    
    var beacon: CLBeacon?
    
    var id: UUID = UUID()
    
    var name: String
    
    var far: Double
    var uuid : String
    var batteryLevel: Int
    
    var aproximity: Aproximity
    
    
    
    init(beacon: CLBeacon?, name: String, far: Double, uuid: String, batteryLevel: Int, aproximity: Aproximity) {
        self.beacon = beacon
        self.name = name
        self.far = far
        self.uuid = uuid
        self.batteryLevel = batteryLevel
        self.aproximity = aproximity
    }
    


    
}
enum Aproximity : String{
    
    case near = "Near"
    case close = "Close"
    case far = "Far"
    case unknown = "Unknown"
    static func getAproximityBaseFar(far : Double) -> Aproximity{
        
        if far >= 0 && far <= 3 {
            return .near
        }else if far > 3 && far <= 8 {
            return .close
        }else if far > 8 {
            return .far
        }
        return .unknown
    }
    
}


