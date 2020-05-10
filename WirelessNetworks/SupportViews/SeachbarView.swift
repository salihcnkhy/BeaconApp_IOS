//
//  SeachbarView.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 9.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import SwiftUI

struct SeachbarView: View {
    
    let barHeight : CGFloat
    @Binding var searchText : String
    
    var body: some View {
        HStack {
            HStack(alignment: .center){
                Image(systemName: "magnifyingglass")
                    .font(.system(size: barHeight/2)).padding()
                TextField("Search", text: $searchText)
                    .font(.getChalkboardSE(size: barHeight/2))
                    .offset(x: 0, y: -2)
            }.overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black,lineWidth: 1)
                    .frame(height : barHeight)
            ).frame(height : barHeight)
                .padding(.trailing,7)
            Button(action: {
            }, label: {
                
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: barHeight)).foregroundColor(Color.black)
            })
        }
    }

}

