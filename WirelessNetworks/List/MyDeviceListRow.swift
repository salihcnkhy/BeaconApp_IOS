//
//  DeviceListRow.swift
//  WirelessNetworks
//
//  Created by Gülnur Kasarcı on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct MyDeviceListRow: View {
    
    @State var device : KnownDevice
    let cellHeight : CGFloat
    
    
    
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .fill(rowColor())
               .shadow(color: Color(UIColor.black.withAlphaComponent(0.25)),
                radius: 5, x: 3, y: -1)
            
            VStack(alignment: .center, spacing: 10){
                
                Text(device.name)
                    .foregroundColor(Color.orange)
                    .padding(.top,5)
                    .font(.getChalkboardSE(size: 25))
                
                GeometryReader { geometry in
                    HStack(spacing : 10){
                                                
                        VStack(alignment: .leading){
                            Image("macbook-pro")
                                .resizable()
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black,lineWidth: 0.2)
                            ).shadow(radius: 5)
                            Spacer()
                            Text(self.device.inRange ? "In Range" : "Not In Range")
                                .font(.getChalkboardSE(size: 13))
                                .foregroundColor(self.device.inRange ? Color.green : Color.red)
                                .padding(.bottom,5)
                            
                        }.padding(.leading,20)
                            .frame(width: geometry.size.width/2)
                        
                        VStack(alignment: .center){
                            Text(String(format : "Far : %.2f MT",self.device.far))
                                .font(.getChalkboardSE(size: 27))
                                .fontWeight(.bold)
                                .frame(maxWidth : .infinity)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                                .offset(x: 0, y: -20)
                            
                            
                            Text(String(format: "Battery : %d%%", self.device.batteryLevel))
                                .font(.getChalkboardSE(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(self.batteryColor())
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                            
                        }.padding(.trailing,25)
                            .frame(width: geometry.size.width/2,
                                   height: geometry.size.height)
                    }
                }}
            
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
    func batteryColor() -> Color {
        
        let level = device.batteryLevel
        
        if level <= 100 && level >= 75{
            return Color.green
        }else if level < 75 && level >= 20{
            return Color.orange
        }else if level < 20 && level >= 0{
            return Color.red
        }
        return Color.gray
    }
    
    
}

struct DeviceListRow_Previews: PreviewProvider {
    static var previews: some View {
        MyDeviceListRow(device: KnownDevice(name: "Device 1", far: 2, batteryLevel:50, inRange: true),cellHeight: 200)
    }
}
