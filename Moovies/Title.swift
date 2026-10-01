//
//  Title.swift
//  Moovies
//
//  Created by mahmoud on 28/09/2026.
//

import SwiftData

struct TMDBAPIObject: Decodable{
    var results: [Title] = []
}


@Model
class Title: Codable, Identifiable, Hashable {
    @Attribute(.unique) var id: Int?
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    
    
    init(
        id: Int? = nil,
        title: String? = nil,
        name: String? = nil,
        overview: String? = nil,
        posterPath: String? = nil
    ) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
    }
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case name
        case overview
        case posterPath
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey:  .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        posterPath = try container
            .decodeIfPresent(String.self, forKey: .posterPath)
    }
    
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(overview, forKey: .overview)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
    }

    
    static var previewTitles = [
        Title(id: 1,title: "BeetleJuice" ,name: "BeetleJuice",overview: "A movie about  BeetleJuice",posterPath:Constants.testTitleURL,),
        Title(
            id: 2,
            title: "Pulp Fiction" ,
            name: "Pulp Fiction",
            overview: "A movie about  Pulp Fiction",
            posterPath:Constants.testTitleURL2,
        ),
        Title(id: 3,title: "The Dark Knight" ,name: "The Dark Knight",overview: "A movie about  The Dark Knight",posterPath:Constants.testTitleURL3,)
    ]
}
