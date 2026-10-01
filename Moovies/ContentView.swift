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
                UpcomingView()
            } label: {
                Image(systemName: Constants.upcomingIcon)
            }

            Tab {
                SearchView()
            } label: {
                Image(systemName: Constants.searchIcon)
            }

            Tab {
                DownloadView()
            } label: {
                Image(systemName: Constants.downloadIcon)
            }
        }
         
    }
}

#Preview {
    ContentView()
}
