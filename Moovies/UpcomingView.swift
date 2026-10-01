//
//  UpcomingView.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 30/09/2026.
//

import SwiftUI

struct UpcomingView: View {
    let viewModel = ViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            GeometryReader { geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(
                        titles: viewModel.upcomingMovies,
                        canDelete: false
                    )
                case .failed(let underlyingError):
                    Text(underlyingError.localizedDescription)
                        .errorMessage()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .navigationTitle(Constants.upcomingString)
            .toolbarTitleDisplayMode(.inline)
            .task {
                await viewModel.getUpcomingMovies()
            }
        }
    }
}

#Preview {
    UpcomingView()
}
