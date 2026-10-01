//
//  SearchView.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 01/10/2026.
//

import SwiftUI

struct SearchView: View {
    @State private var searchByMovies = true
    @State private var searchText = ""
    private let searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()
    
    var titles: [Title]    {
        searchViewModel.searchTitles
    }
    
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                if let error = searchViewModel.errorMessage {
                    Text(error)
                        .errorMessage()
                    
                }
                if titles.isEmpty {
                    ContentUnavailableView(
                        Constants.noTitlesFound,
                        systemImage: "exclamationmark.icloud"
                    )
                } else {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                        ForEach(titles) { title in
                            AsyncImage(
                                url: URL(
                                    string: title.posterPath ?? "",
                                )
                            ) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(.rect(cornerRadius: 10))
                                
                            } placeholder: {
                                ProgressView()
                                
                            }
                            .frame(width: 120, height: 200)
                            .onTapGesture {
                                navigationPath.append(title)
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle(
                searchByMovies ? Constants.movieSearchString : Constants
                    .tvSearchString)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        searchByMovies.toggle()
                        
                        Task {
                            await searchViewModel
                                .searchTitle(
                                    by: searchByMovies ? MediaTypes.searchMovies : MediaTypes.searchTvs,
                                    for: searchText
                                )
                        }
                    } label: {
                        Image(
                            systemName: searchByMovies ? Constants.movieIconString : Constants.tvIconString
                        )
                    }
                }
            }
            .searchable(
                text: $searchText,
                placement:  .toolbar,
                prompt: searchByMovies ? Constants.moviePlaceHolderString : Constants.tvPlaceHolderString
            )
            .task(id: searchText) {
                try? await Task.sleep(for: .milliseconds(500))
                
                if Task.isCancelled {
                    return
                }
                
                await searchViewModel
                    .searchTitle(
                        by: searchByMovies ? MediaTypes.searchMovies : MediaTypes.searchTvs,
                        for: searchText
                    )
            }
            .navigationDestination(for: Title.self) { title in
                TitleDetailView(title: title)
            }
        }
    }
}

#Preview {
    SearchView()
}
