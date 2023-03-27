//
//  TrendingMovieDayModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 17/03/2023.
//

import Foundation

struct MovieModelForDays: Codable {
    var page         : Int?             = nil
    var results      : [MovieForDay]?   = []
    var totalPages   : Int?             = nil
    var totalResults : Int?             = nil
    
    enum CodingKeys: String, CodingKey {
        case page         = "page"
        case results      = "results"
        case totalPages   = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        page         = try values.decodeIfPresent(Int.self              , forKey: .page         )
        results      = try values.decodeIfPresent([MovieForDay].self    , forKey: .results      )
        totalPages   = try values.decodeIfPresent(Int.self              , forKey: .totalPages   )
        totalResults = try values.decodeIfPresent(Int.self              , forKey: .totalResults )
    }
    
    init() { }
    
}

// MARK: - Result
struct MovieForDay: Codable {
    var adult            : Bool?   = nil
    var backdropPath     : String? = nil
    var id               : Int?    = nil
    var title            : String? = nil
    var originalLanguage : String? = nil
    var originalTitle    : String? = nil
    var overview         : String? = nil
    var posterPath       : String? = nil
    var mediaType        : String? = nil
    var genreIds         : [Int]?  = []
    var popularity       : Double? = nil
    var releaseDate      : String? = nil
    var video            : Bool?   = nil
    var voteAverage      : Double? = nil
    var voteCount        : Int?    = nil
    
    enum CodingKeys: String, CodingKey {
        case adult            = "adult"
        case backdropPath     = "backdrop_path"
        case id               = "id"
        case title            = "title"
        case originalLanguage = "original_language"
        case originalTitle    = "original_title"
        case overview         = "overview"
        case posterPath       = "poster_path"
        case mediaType        = "media_type"
        case genreIds         = "genre_ids"
        case popularity       = "popularity"
        case releaseDate      = "release_date"
        case video            = "video"
        case voteAverage      = "vote_average"
        case voteCount        = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        adult            = try values.decodeIfPresent(Bool.self   , forKey: .adult            )
        backdropPath     = try values.decodeIfPresent(String.self , forKey: .backdropPath     )
        id               = try values.decodeIfPresent(Int.self    , forKey: .id               )
        title            = try values.decodeIfPresent(String.self , forKey: .title            )
        originalLanguage = try values.decodeIfPresent(String.self , forKey: .originalLanguage )
        originalTitle    = try values.decodeIfPresent(String.self , forKey: .originalTitle    )
        overview         = try values.decodeIfPresent(String.self , forKey: .overview         )
        posterPath       = try values.decodeIfPresent(String.self , forKey: .posterPath       )
        mediaType        = try values.decodeIfPresent(String.self , forKey: .mediaType        )
        genreIds         = try values.decodeIfPresent([Int].self  , forKey: .genreIds         )
        popularity       = try values.decodeIfPresent(Double.self , forKey: .popularity       )
        releaseDate      = try values.decodeIfPresent(String.self , forKey: .releaseDate      )
        video            = try values.decodeIfPresent(Bool.self   , forKey: .video            )
        voteAverage      = try values.decodeIfPresent(Double.self , forKey: .voteAverage      )
        voteCount        = try values.decodeIfPresent(Int.self    , forKey: .voteCount        )
    }
    
    init() { }
    
}
