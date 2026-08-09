//
//  IntermissionApp.swift
//  Intermission
//
//  Created by Shambhavi Verma on 06/08/26.
//

import SwiftUI

@main
struct IntermissionApp: App {
    // Shared state for the watchlist
    @StateObject private var watchlistManager = WatchlistManager()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(watchlistManager)
                .preferredColorScheme(.dark)
                .tint(.cinemaRed)
        }
    }
}
