//
//  AllDeviceListRow.swift
//  WirelessNetworks
//
//  Created by Gülnur Kasarcı on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct AllDeviceListRow: View {
    
    @State var device : Device
    let cellHeight : CGFloat
    
    var body: some View {
          ZStack{
                  
                  RoundedRectangle(cornerRadius: 10)
                      .fill(rowColor())
                      .shadow(color: Color(UIColor.black.withAlphaComponent(0.25)),
                      radius: 5, x: 3, y: -1)
            VStack{
                Text(device.name)
                    .font(.getChalkboardSE(size: 30))
                Text(String(format : "Far : %.2f MT",device.far))
                    .font(.getChalkboardSE(size: 25))
            }
        }.frame(height : cellHeight)
        .padding([.leading,.trailing],10.0)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
    
    func rowColor() -> LinearGradient{
           switch device.aproximity {
           case .near:
               return Color.nearDevice
           case .close:
               return Color.closeDevice
           case .far:
               return Color.farDevice
           case .unknown:
               return Color.farDevice
           }
       }
}

