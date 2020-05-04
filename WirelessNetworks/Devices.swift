//
//  Devices.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import Foundation


protocol Device {
     
    var id : UUID {get set}
    var name : String {get}
    var far : Double {get}
    var batteryLevel : Int {get}
    var aproximity : Aproximity {get set}

   
    
}


struct KnownDevice : Device {

    var id: UUID = UUID()
    
    var name: String
    
    var far: Double
    
    var batteryLevel: Int
    
    var aproximity: Aproximity

    var inRange : Bool
    
    init(name : String , far : Double , batteryLevel : Int, inRange : Bool) {
        
        self.name = name
        self.far = far
        self.batteryLevel = batteryLevel
        self.aproximity = Aproximity.getAproximityBaseFar(far: far)
        self.inRange = inRange
    }
    

    
}


struct UnknownDevice : Device {
    
    var id: UUID = UUID()
    
    

    var name: String
    
    var far: Double
    
    var batteryLevel: Int
    
    var aproximity: Aproximity
    
    
    
    init(name : String , far : Double , batteryLevel : Int) {
        
        self.name = name
        self.far = far
        self.batteryLevel = batteryLevel
        self.aproximity = Aproximity.getAproximityBaseFar(far: far)
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


