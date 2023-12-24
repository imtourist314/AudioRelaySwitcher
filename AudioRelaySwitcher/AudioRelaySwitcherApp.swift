//
//  AudioRelaySwitcherApp.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-12.
//

import SwiftUI
import SwiftData

@main
struct AudioRelaySwitcherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [EndPoint.self,Relay.self] )
        }
    }
}
