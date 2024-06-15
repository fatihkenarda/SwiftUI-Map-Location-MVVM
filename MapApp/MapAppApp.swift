//
//  MapAppApp.swift
//  MapApp
//
//  Created by Fatih Kenarda on 14.06.2024.
//

import SwiftUI

@main
struct MapAppApp: App {
    @StateObject private var locationViewModel = LocationViewModel()
    
    var body: some Scene {

        WindowGroup {
            LocationView()
                .environmentObject(locationViewModel)
        }
    }
}
