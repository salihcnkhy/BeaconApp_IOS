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
    
    @ObservedObject var deviceList = Devices()
    
    @State var isAddViewShowing = false {
        willSet{
            if(newValue){
                print("True oldu arama yapma")
                BluetoothTasks.shared.StopSearching()
            }else{
                print("false oldu arama yap")
                BluetoothTasks.shared.StartSearching(notificationName: .beaconsFound)
            }
        }
    }
    
    init() {
        
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "ChalkboardSE-Bold", size: 45)!]
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        NavigationView{
            GeometryReader{ geometry in
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack{
                    SeachbarView(barHeight: 35, searchText: self.$searchText)
                        .padding([.leading,.trailing],12)
                        .padding(.bottom,5)
                    DeviceList(devices: self.deviceListFilter())
                }.padding(.top)
<<<<<<< HEAD
                if self.isAddViewShowing{
                    DeviceAddView(cellHeight: geometry.size.height+15, deviceList: self.$deviceList,isAddViewShowing: self.$isAddViewShowing).transition(.moveAndFade).zIndex(1)
                }
                
            }.navigationBarTitle(self.isAddViewShowing ? "Add Device" : "Devices").navigationBarItems(trailing: addButton())
            
        }.environment(\.colorScheme, colorScheme == .dark ? .light : .light)
            .onAppear{
                NotificationCenter.default.addObserver(forName: .beaconsFound , object: nil, queue: nil, using: self.didBeaconsRefresh)
                BluetoothTasks.shared.StartSearching(all: self.deviceList, notificationName: .beaconsFound)
=======
            }.navigationBarTitle("Devices").navigationBarItems(trailing: addButton())
                .sheet(isPresented: self.$isAddViewShowing, onDismiss: {
                    self.isAddViewShowing = false
                } ){
                    DeviceAddView(isAddViewShowing: self.$isAddViewShowing)}
>>>>>>> 2c38e755a7ec571effebd2533388f98dc0fec864
        }
        .onAppear{
            NotificationCenter.default.addObserver(forName: .beaconsFound , object: nil, queue: nil, using: self.didBeaconsRefresh)
            BluetoothTasks.shared.StartSearching(notificationName: .beaconsFound)
        }.environment(\.colorScheme, .light)
    }
    
    func addButton() -> some View {
        return Button(action: {
            self.isAddViewShowing.toggle()
        }, label: {
<<<<<<< HEAD
            self.isAddViewShowing ?
                AnyView(Text("Close").font(.system(size: 20)).animation(.spring()))
                : AnyView(Image(systemName: "plus").font(.system(size: 30)))
=======
            Image(systemName: "plus")
                .font(.system(size: 30))
>>>>>>> 2c38e755a7ec571effebd2533388f98dc0fec864
        })
    }
    
    func didBeaconsRefresh(_ notification : Notification){
        if let beacons = notification.object as? [CLBeacon]{
            for (index, device) in deviceList.allDevices.enumerated() {
                var foundBeacon : CLBeacon?
                for beacon in beacons {
                    if beacon.uuid == device.uuid && beacon.rssi != 0{
                        foundBeacon = beacon
                    }
                }
                //print(beacons)
                if let beacon = foundBeacon {
                  //  deviceList.objectWillChange.send()
                    deviceList.allDevices[index].isFound = true
                    deviceList.allDevices[index].far = beacon.accuracy.magnitude
                    deviceList.allDevices[index].rssi = beacon.rssi
                }else{
                    if device.rssi != 0{
                       // deviceList.objectWillChange.send()
                        deviceList.allDevices[index].rssi = 0
                    }
                }
                print(device)
            }
        }
    }
    
    func deviceListFilter() -> [Device]{
        var devices : [Device] = []
        devices = deviceList.allDevices.filter { device in
            return (device.name.lowercased(with : .current).hasPrefix(self.searchText.lowercased(with: .current)))
        }
        return devices
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceListPage()
    }
}
