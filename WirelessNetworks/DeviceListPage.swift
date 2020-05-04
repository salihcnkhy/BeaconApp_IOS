//
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 2.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct DeviceListPage: View {
    
    @State var deviceListDecision : DeviceListDecision = .MyDevices
    @State var searchText : String = ""
    
    var deviceList : [Device] = []
    init() {
        
        self.deviceList = DummyList();
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
                        DeviceList(deviceList: self.deviceListFilter() , deviceListDecision: self.deviceListDecision).id(UUID())
                        }.padding(.top)
                }.navigationBarTitle("Devices")
                    .navigationBarItems(trailing: self.ListDesicionBarButton())
                
            }
            
            
        }
    }
    
    func deviceListFilter() -> [Device]{
        var devices : [Device] = []
        devices = deviceList.filter {
            
            switch deviceListDecision{
                
            case .MyDevices:
                if let device = $0 as? KnownDevice{
                    return (device.name.lowercased(with : .current).hasPrefix(self.searchText.lowercased(with: .current)))
                }else{
                   return false
                }
            case .AllDevices:
               return ($0.name.lowercased(with : .current).hasPrefix(self.searchText.lowercased(with: .current)))
                
            }
           
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
    
    
    func AddDeviceButton(geometry : GeometryProxy) -> some View {
        
        return Button(action: AddDeviceAction, label:{
            ZStack{
                Circle().fill(Color.gray)
                Image(systemName: "plus").font(.system(size :25)).foregroundColor(.white)
            }
        }).frame(width: geometry.size.width*0.15,
            height: geometry.size.width*0.15)
            .alignmentGuide(VerticalAlignment.center) { _ in
                -geometry.size.height/2+geometry.size.width*0.17
        }
        .shadow(color: Color(UIColor.black.withAlphaComponent(0.8)),
                radius: 3, x: 2, y: 2)
        
    }
    
    
    func ListDesicionBarButton() -> some View{
        
        return Button(deviceListDecision.rawValue){
            self.deviceListDecision = self.deviceListDecision == DeviceListDecision.MyDevices ? .AllDevices : .MyDevices
        }.font(.getChalkboardSE(size: 20))
    }
    
    
    
    
    
    func AddDeviceAction(){
        deviceListDecision = .AllDevices
    }
    
    
    func DummyList() -> [Device]{
        
        var list : [Device] = []
        
        for i in 0...3 {
            
            list.append(KnownDevice(name: "Device_\(i)" , far: Double(i)*3.2, batteryLevel: i*i,inRange:  false))
            
        }
        for i in 0...5 {
            
            list.append(KnownDevice(name: "Device_\(i)" , far: Double(i)*3.2, batteryLevel: i*i,inRange:  true))
            
        }
        for i in 0...5 {
            
            list.append(UnknownDevice(name: "Device_\(i)" , far: Double(i)*3.2, batteryLevel: i*i))
            
        }
        return list
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceListPage()
    }
}

enum DeviceListDecision : String {
      case AllDevices = "All Devices"
      case MyDevices = "My Devices"
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
