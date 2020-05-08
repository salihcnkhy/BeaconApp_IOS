//
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 2.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI
import CoreLocation

struct DeviceListPage: View {
    
    @State var searchText : String = ""
    
    @State var deviceList : [Device] = [Device(uuid: "59F9F7D1-86DB-4198-A623-130E931DF45B", minor: 0, major: 100, name: "Beacon")]
    @State var foundDevices : [CLBeacon] = []
    
    init() {
        
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "ChalkboardSE-Bold", size: 45)!]
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        ZStack {
            NavigationView{
                GeometryReader{ geometry in
                    Color.backgroundColor.edgesIgnoringSafeArea(.all)
                    VStack{
                        self.SearchBarView(height: 35)
                            .padding([.leading,.trailing],12)
                            .padding(.bottom,5)
                        DeviceList(devices: self.deviceListFilter())
                    }.padding(.top)
                }.navigationBarTitle("Devices")
                
            }
            
            
        }.onAppear{
            NotificationCenter.default.addObserver(forName: .beaconFound , object: nil, queue: nil, using: self.didBeaconsRefresh)
            
            BluetoothTasks.shared.StartSearching(all: self.deviceList)
            
        }
    }
    func didBeaconsRefresh(_ notification : Notification){
        if var beacons = notification.object as? [CLBeacon]{
            beacons = beacons.filter{ beacon in
                return beacon.rssi != 0
            }
            print(beacons)
            for (index, device) in deviceList.enumerated() {
                var isFound = false
                var foundBeacon : CLBeacon?
                for beacon in beacons {
                    if beacon.uuid.uuidString == device.uuid{
                        isFound = true
                        foundBeacon = beacon
                        break
                    }
                }
                if isFound{
                    deviceList[index].isFound = true
                    deviceList[index].far = foundBeacon!.accuracy.magnitude
                }else{
                    deviceList[index].isFound = false
                    deviceList[index].far = 0

                }
            }
            
        }
        
    }
    
    
    func deviceListFilter() -> [Device]{
        var devices : [Device] = []
        devices = deviceList.filter { device in
            return (device.name.lowercased(with : .current).hasPrefix(self.searchText.lowercased(with: .current)))
        }
        return devices
    }
    
    func SearchBarView(height : CGFloat) -> some View{
        
        return HStack {
            HStack(alignment: .center){
                Image(systemName: "magnifyingglass")
                    .font(.system(size: height/2)).padding()
                
                TextField("Search", text: self.$searchText)
                    .font(.getChalkboardSE(size: height/2))
                    .offset(x: 0, y: -2)
                
            }.overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black,lineWidth: 1)
                    .frame(height : height)
            ).frame(height : height)
                .padding(.trailing,7)
            
            Button(action: {
                
            }, label: {
                
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: height)).foregroundColor(Color.black)
                
            })
            
            
            
        }
        
        
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceListPage()
    }
}



extension Color {
    
    public static let backgroundColor = LinearGradient(gradient: Gradient(colors: [Color(red: 158/255, green: 173/255, blue: 120/255),Color(red: 128/255, green: 163/255, blue: 1, opacity: 1)]), startPoint: .top, endPoint: .bottom)
    public static let backgroundColorLowOpacity = LinearGradient(gradient: Gradient(colors: [Color(red: 158/255, green: 173/255, blue: 120/255),Color(red: 128/255, green: 163/255, blue: 1, opacity: 0.2)]), startPoint: .top, endPoint: .bottom)
    
    public static let nearDevice = LinearGradient(gradient: Gradient(colors: [Color(red: 228/255, green: 228/255, blue: 228/255), Color(red: 232/255, green: 255/255, blue: 182/255)]), startPoint: .top, endPoint: .bottom)
    public static let farDevice  = LinearGradient(gradient: Gradient(colors: [Color(red: 228/255, green: 228/255, blue: 228/255),Color(red: 255/255, green: 182/255, blue: 182/255)]), startPoint: .top, endPoint: .bottom)
    public static let closeDevice  = LinearGradient(gradient: Gradient(colors: [Color(red: 228/255, green: 228/255, blue: 228/255),Color(red: 255/255, green: 217/255, blue: 182/255)]), startPoint: .top, endPoint: .bottom)
}

extension Font{
    public static func getChalkboardSE(size : CGFloat) -> Font {
        return Font.custom("ChalkboardSE-Bold", size: size)
    }
}
