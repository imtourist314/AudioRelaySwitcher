//
//  Settings.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-12.
//

import Foundation
import SwiftUI

struct SettingsView:View {
    var body:some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors:[.gray,.white]),
                           startPoint: .topLeading,endPoint:.bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}
