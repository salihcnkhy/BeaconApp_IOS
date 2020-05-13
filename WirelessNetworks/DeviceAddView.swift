//
//  DeviceAddView.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 9.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct DeviceAddView: View {
    
    @ObservedObject var deviceList = Devices()
    @Binding var isAddViewShowing : Bool
    @State var uuidText = "59F9F7D1-86DB-4198-A623-130E931DF45B"
    @State var nameText = ""
    @State var majorText = "100"
    @State var minorText = "0"

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15).fill(Color.white)
                .shadow(color: Color(UIColor.black.withAlphaComponent(0.25)),
                        radius: 5, x: 3, y: -1).overlay(
                            RoundedRectangle(cornerRadius: 15).stroke(Color.gray,lineWidth: 0.3))
            VStack(alignment: .center, spacing: 10){
                RoundedTextField(height: 50, title: "Beacon Name", text: $nameText)
                RoundedTextField(height: 50, title: "UUID", text: $uuidText)
                RoundedTextField(height: 50,  title: "Major", text: $majorText)
                RoundedTextField(height: 50,  title: "Minor", text: $minorText)
                Button(action: {
                    if let uuid = UUID(uuidString: self.uuidText){
                        if let minor = Int(self.minorText), let major = Int(self.majorText){
                            let newDevice = Device(uuid: uuid, minor: minor, major: major, name: self.nameText)
                            self.deviceList.allDevices.append(newDevice)
                            withAnimation{
                                self.isAddViewShowing = false
                            }
                        }
                    }                    
                }, label: {
                    RoundedRectangle(cornerRadius: 10).stroke(Color.gray , lineWidth: 0.4).overlay(Text("Done"))
                }).frame(height : 50)
            }.padding([.trailing,.leading],20)
        }.environment(\.colorScheme, .light)
            
    }
    
    
    
}
