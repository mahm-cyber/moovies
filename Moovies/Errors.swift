//
//  Errors.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 29/09/2026.
//

import Foundation


enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API configuration file not found."
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data from API configuration file \(error.localizedDescription)"
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode API configuration \(error.localizedDescription)"
        }
    }
}


enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlayingError: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlayingError: let error):
            return "Failed to parse URL response: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing API configuration"
        case .urlBuildFailed:
            return "Failed to build URL."
        }
    }
}
