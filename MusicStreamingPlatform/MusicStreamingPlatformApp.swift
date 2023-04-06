//
//  MusicStreamingPlatformApp.swift
//  MusicStreamingPlatform
//
//  Created by Bardia Naderi on 2023-01-04.
//

import SwiftUI
import FirebaseCore

@main
struct MusicStreamingPlatformApp: App {
    let data = OurData()
    
    init(){
        FirebaseApp.configure()
        data.loadAlbums()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
