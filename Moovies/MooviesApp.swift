//
//  MooviesApp.swift
//  Moovies
//
//  Created by mahmoud on 28/09/2026.
//

import SwiftUI
import SwiftData

@main
struct MooviesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
