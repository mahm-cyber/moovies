//
//  ContentView.swift
//  Moovies
//
//  Created by mahmoud on 28/09/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab {
                HomeView()
            } label: {
                Image(systemName: Constants.homeIcon)
            }

            Tab {
                Text(Constants.upcomingString)
            } label: {
                Image(systemName: Constants.upcomingIcon)
            }

            Tab {
                Text(Constants.searchString)
            } label: {
                Image(systemName: Constants.searchIcon)
            }

            Tab {
                Text(Constants.downloadString)
            } label: {
                Image(systemName: Constants.downloadIcon)
            }
        }
        .onAppear {
            if let config = APIConfig.shared
            {
                print(config.tmdbAPIKey)
                print(config.tmdbBaseURL)
            }
        }
    }
}

#Preview {
    ContentView()
}
