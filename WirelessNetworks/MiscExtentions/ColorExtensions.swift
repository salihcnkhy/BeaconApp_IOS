//
//  ColorExtensions.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 11.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    
    public static let backgroundColor = LinearGradient(gradient: Gradient(colors: [Color(red: 158/255, green: 173/255, blue: 120/255),Color(red: 128/255, green: 163/255, blue: 1, opacity: 1)]), startPoint: .top, endPoint: .bottom)
    public static let backgroundColorLowOpacity = LinearGradient(gradient: Gradient(colors: [Color(red: 158/255, green: 173/255, blue: 120/255),Color(red: 128/255, green: 163/255, blue: 1, opacity: 0.2)]), startPoint: .top, endPoint: .bottom)
    
    public static let nearDevice = LinearGradient(gradient: Gradient(colors: [Color(red: 228/255, green: 228/255, blue: 228/255), Color(red: 232/255, green: 255/255, blue: 182/255)]), startPoint: .top, endPoint: .bottom)
    public static let farDevice  = LinearGradient(gradient: Gradient(colors: [Color(red: 228/255, green: 228/255, blue: 228/255),Color(red: 255/255, green: 182/255, blue: 182/255)]), startPoint: .top, endPoint: .bottom)
    public static let closeDevice  = LinearGradient(gradient: Gradient(colors: [Color(red: 228/255, green: 228/255, blue: 228/255),Color(red: 255/255, green: 217/255, blue: 182/255)]), startPoint: .top, endPoint: .bottom)
}
