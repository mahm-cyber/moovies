//
//  YoutubeSearchResponse.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 30/09/2026.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperites?
}


struct IdProperites: Codable {
    let videoId: String?
}
