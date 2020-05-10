//
//  TextFieldWithBorder.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 9.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct RoundedTextField: View {
    
    let height : CGFloat
    let title : String
    @Binding var text : String
    var body: some View {
        TextField(title, text: $text)
            .font(.system(size: height/2))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(height: height)
    }
}


