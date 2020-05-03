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
    var aproximity : Aproximity
    var inRange : Bool
    
    init(name : String , far : Double , batteryLevel : Int) {
        
        self.name = name
        self.far = far
        self.batteryLevel = batteryLevel
        self.aproximity = Aproximity.getAproximityBaseFar(far: far)
        self.inRange = true
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
    
}
