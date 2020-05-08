//
//  DeviceList.swift
//  WirelessNetworks
//
//  Created by Gülnur Kasarcı on 8.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct DeviceList: View {
    
    var devices : [Device]

    var body: some View {
        List{
            
            ForEach(devices) { device in
                withAnimation{
                    ListRow(device: device, cellHeight: 150).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                }
              
            }
            
        }.id(UUID())
    }
}

struct DeviceList_Previews: PreviewProvider {
    static var previews: some View {
        DeviceList(devices: [Device(uuid: "xxxxxxxxxx-xxxx-xxx", minor: 2, major: 200, name: "Cüzdan"),Device(uuid: "xxxxxxxxxx-xxxx-xxx", minor: 2, major: 200, name: "Cüzdan2"),Device(uuid: "xxxxxxxxxx-xxxx-xxx", minor: 2, major: 200, name: "Cüzdan3"),Device(uuid: "xxxxxxxxxx-xxxx-xxx", minor: 2, major: 200, name: "Cüzdan4")])
    }
}
