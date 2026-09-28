//
//  Title.swift
//  Moovies
//
//  Created by mahmoud on 28/09/2026.
//

import Foundation

struct APIObject: Decodable {
    var results: [Title] = []
}

struct Title: Codable, Identifiable {
    var id: Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?


}
