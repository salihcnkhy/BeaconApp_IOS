//
//  ListRow.swift
//  WirelessNetworks
//
//  Created by Gülnur Kasarcı on 8.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI
extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}
struct ListRow: View {
    
    var device : Device
    let cellHeight : CGFloat
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10).fill(Color.nearDevice)
                .shadow(color: Color(UIColor.black.withAlphaComponent(0.25)),
                        radius: 5, x: 3, y: -1).overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.gray,lineWidth: 0.3)
            )
            VStack(alignment: .center, spacing: 10){
                
                Text.ChalkboardSEText(label: device.name, fontSize: 25)
                    .foregroundColor(Color.orange)
                    .padding(.top,5)
                
                Text.ChalkboardSEText(label: device.uuid, fontSize: 20)
                    .foregroundColor(Color.gray)
                    .padding(.top,5)
                HStack{
                    Text.ChalkboardSEText(label: device.isFound.description, fontSize: 20)
                        .foregroundColor(device.isFound ? Color.green : Color.red)
                    Spacer()
                    Text.ChalkboardSEText(label:String(format: "%.2f MT", device.far), fontSize: 20)
                        .foregroundColor(device.isFound ? Color.green : Color.red)
                }.padding(.all,10)
                
                
            }}.frame(height : cellHeight)
            .padding([.leading,.trailing],10.0)
    }
}

extension Text {
    
    static func ChalkboardSEText(label : String, fontSize : CGFloat) -> Text {
        return Text(label).font(.getChalkboardSE(size: 25))
        
    }
    
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(device : Device(uuid: "xxxxxxxxxx-xxxx-xxx", minor: 2, major: 200, name: "Cüzdan"),cellHeight: 150)
    }
}
