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
    
    var body: some View {
        List{
            
            ForEach(deviceList){
                device in
                MyDeviceListRow(device: device,cellHeight: 200)
            }
        }
    }
}

