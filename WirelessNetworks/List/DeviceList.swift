//
//  DeviceList.swift
//  WirelessNetworks
//
//  Created by Gülnur Kasarcı on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct DeviceList: View {
    
    var deviceList : [Device]
    let deviceListDecision : DeviceListDecision
    var body: some View {
        List{
            ForEach(deviceList, id:\.id){ device in
                self.returnRow(device : device)
            }
        }
    }
    
    func returnRow(device : Device) -> AnyView{
        
        switch deviceListDecision {
        case .MyDevices:
            return AnyView(MyDeviceListRow(device : device as! KnownDevice , cellHeight : 200))
        case .AllDevices:
            return AnyView(AllDeviceListRow(device: device, cellHeight: 100))
       
    }
}
    
}
