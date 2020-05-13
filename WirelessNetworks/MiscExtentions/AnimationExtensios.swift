//
//  AnimationExtensios.swift
//  WirelessNetworks
//
//  Created by Salihcan Kahya on 11.05.2020.
//  Copyright © 2020 Salihcan Kahya. All rights reserved.
//

import Foundation
import SwiftUI
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        let insertion = AnyTransition.move(edge: .bottom)
        let removal = AnyTransition.move(edge :.bottom)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
