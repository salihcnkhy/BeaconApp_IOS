//
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 2.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI
import CoreLocation
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
        let removal = AnyTransition.move(edge :.bottom)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}


struct DeviceListPage: View {
    
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    
    @State var searchText : String = ""
    
    @State var deviceList : [Device] = [Device(uuid: UUID(uuidString: "59F9F7D1-86DB-4198-A623-130E931DF45B")!, minor: 0, major: 100, name: "Beacon")] {
        willSet{

        }
    }
    @State var foundDevices : [CLBeacon] = []
    @State var isAddViewShowing = false {
        didSet{
            if(self.isAddViewShowing){
                print("True oldu arama yapma")
                BluetoothTasks.shared.StopSearching(all: self.deviceList)
            }else{
                print("false oldu arama yap")
                BluetoothTasks.shared.StartSearching(all: self.deviceList, notificationName: .beaconsFound)

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
                if self.isAddViewShowing{
                    DeviceAddView(cellHeight: geometry.size.height+15, deviceList: self.$deviceList,isAddViewShowing: self.$isAddViewShowing).transition(.moveAndFade).zIndex(1)
                }
                
            }.navigationBarTitle(self.isAddViewShowing ? "Add Device" : "Devices").navigationBarItems(trailing: addButton())
            
        }.environment(\.colorScheme, colorScheme == .dark ? .light : .light)
            .onAppear{
                NotificationCenter.default.addObserver(forName: .beaconsFound , object: nil, queue: nil, using: self.didBeaconsRefresh)
                BluetoothTasks.shared.StartSearching(all: self.deviceList, notificationName: .beaconsFound)
        }
    }
    
    func addButton() -> some View {
        return Button(action: {
            withAnimation{
                self.isAddViewShowing.toggle()
            }
        }, label: {
            self.isAddViewShowing ?
                AnyView(Text("Close").font(.system(size: 20)).animation(.spring()))
                : AnyView(Image(systemName: "plus").font(.system(size: 30)))
        })
    }
    
    func didBeaconsRefresh(_ notification : Notification){
        if var beacons = notification.object as? [CLBeacon]{
            beacons = beacons.filter{ beacon in
                return beacon.rssi != 0
            }
            for (index, device) in deviceList.enumerated() {
                var isFound = false
                var foundBeacon : CLBeacon?
                for beacon in beacons {
                    if beacon.uuid == device.uuid{
                        isFound = true
                        foundBeacon = beacon
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
