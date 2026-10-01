//
//  SearchViewModel.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 01/10/2026.
//

import Foundation


@Observable
class SearchViewModel {
    private(set) var errorMessage: String?
    private(set) var searchTitles: [Title] = []
    private let dataFetcher = DataFetcher()
    
    func searchTitle(by media: MediaTypes, for title: String) async {
        do {
            errorMessage = nil
            if title.isEmpty {
                searchTitles = try await dataFetcher
                    .fetchTitles(
                        for: media ==  .searchMovies ? MediaTypes.trendingMovies : MediaTypes.trendingTvs,
                        with: title
                    )
            } else {
                searchTitles = try await dataFetcher
                    .fetchTitles(for: media, with: title)
            }
        } catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}
