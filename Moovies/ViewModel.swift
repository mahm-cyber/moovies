//
//  ViewModel.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 29/09/2026.
//

import Foundation


@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private(set) var videoIdStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    var trendingMovies: [Title] = []
    var trendingTvs: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTvs: [Title] = []
    
    
    var heroTitle = Title.previewTitles[0]
    var videoId = ""
    
    
    func getTitles() async {
        homeStatus = .fetching
        if trendingMovies.isEmpty {
            do {
                async let tMovies =  dataFetcher
                    .fetchTitles(for: MediaTypes.trendingMovies)
                async let tTV = dataFetcher.fetchTitles(for: .trendingTvs)
                async let tRMovies =  dataFetcher
                    .fetchTitles(for: .topRatedMovies)
                async let tRTv =  dataFetcher.fetchTitles(for: .topRatedTvs)
                
                trendingMovies = try await tMovies
                trendingTvs = try await tTV
                topRatedMovies = try await tRMovies
                topRatedTvs = try await tRTv
                
                if let title = trendingMovies.randomElement() {
                    heroTitle = title
                }
                homeStatus = .success
            } catch {
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        } else {
            homeStatus = .success
        }
    }
    
    func getVideoId(for title: String) async {
        videoIdStatus = .fetching
        
        do {
            videoId = try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = .success
        } catch {
            videoIdStatus = .failed(underlyingError: error)
        }
    }
}
