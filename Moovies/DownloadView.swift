//
//  DownloadView.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 01/10/2026.
//

import SwiftUI
import SwiftData


struct DownloadView: View {
    @Query(sort: \Title.title) var savedTitles: [Title]
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            if savedTitles.isEmpty {
                Text("No Downloads")
                    .padding()
                    .font(.title3)
                    .bold()
            } else {
                VerticalListView(titles: savedTitles, canDelete: true)
            }
        }
    }
}

#Preview {
    DownloadView()
}
