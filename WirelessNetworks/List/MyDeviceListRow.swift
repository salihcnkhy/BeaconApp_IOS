//
//  DeviceListRow.swift
//  WirelessNetworks
//
//  Created by Gülnur Kasarcı on 3.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct MyDeviceListRow: View {
    
    @State var device : Device
    let cellHeight : CGFloat
    
    var body: some View {
        
        ZStack{
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.nearDevice)
                .shadow(color: Color(UIColor.black.withAlphaComponent(0.6)),
                radius: 5, x: 3, y: 4)
            
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
                            Text("In Range")
                                .font(.getChalkboardSE(size: 13))
                                .foregroundColor(Color.green)
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
                                .foregroundColor(Color.green)
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
}

struct DeviceListRow_Previews: PreviewProvider {
    static var previews: some View {
        MyDeviceListRow(device: Device(name: "Device 1", far: 1.2, batteryLevel: 100),cellHeight: 200)
    }
}
