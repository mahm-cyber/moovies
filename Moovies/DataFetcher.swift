//
//  DataFetcher.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 29/09/2026.
//

import Foundation

enum MediaTypes {
    case trendingMovies
    case topRatedMovies
    case trendingTvs
    case topRatedTvs
    
    var type : String {
        switch self {
        case .trendingMovies, .trendingTvs:
            return  "trending"
            
        case .topRatedMovies, .topRatedTvs:
            return  "top_rated"
        }
    }
    
    var media: String {
        switch self {
        case .trendingMovies, .topRatedMovies:
            return   "movie"
        case .trendingTvs, .topRatedTvs:
            return "tv"
        }
    }
}

struct DataFetcher {
    
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    
    //MARK: - media= movie, media= top_rated
    func fetchTitles(for type:MediaTypes) async throws -> [Title] {
        
        
        let fetchTitlesURL = try buildURL(media: type.media, type: type.type)
        guard let fetchTitlesURL = fetchTitlesURL else {
            throw NetworkError.urlBuildFailed
        }
        print(fetchTitlesURL)
        
        let(data,urlResponse) = try await URLSession.shared.data(
            from: fetchTitlesURL
        )
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError
                .badURLResponse(
                    underlayingError: NSError(
                        domain: "DataFetcher",
                        code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                        userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"])
                )
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObject.self, from: data).results
        
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
    private func buildURL(media: String, type: String) throws -> URL? {
        guard let baseURL = tmdbBaseURL else {
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        
        var path: String
        
        
        if type == "trending" {
            path = "3/trending/\(media)/day"
        } else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        } else {
            throw NetworkError.urlBuildFailed
        }
        
        guard   let url = URL(string: baseURL)?
            .appending(path: path)
            .appending(queryItems: [URLQueryItem(name: "api_key", value: apiKey)])
        else {
            throw NetworkError.urlBuildFailed
        }
        
        return url
        
    }
}
