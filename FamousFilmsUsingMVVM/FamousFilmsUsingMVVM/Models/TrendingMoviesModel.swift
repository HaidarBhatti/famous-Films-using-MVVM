//
//  TrendingMoviesModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import Foundation

struct TrendingMoviesModel: Codable {
    let page: Int
    let results: [TrendingMovies]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TrendingMovies: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalLanguage: OriginalLanguage
    let originalTitle, overview, posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case all = "all"
    case person = "person"
}

enum OriginalLanguage: String, Codable {
    case de = "de"
    case en = "english"
    case ja = "ja"
    case ko = "ko"
    case es = "es"
    case fr = "fr"
    case it = "it"
    case nl = "nl"
}

enum TimeWindow: String, Codable{
    case day = "day"
    case week = "week"
}




struct TrendingWeekMoviesModel: Codable {
  var page         : Int?       = nil
  var results      : [TrendingThisWeekMovies]? = []
  var totalPages   : Int?       = nil
  var totalResults : Int?       = nil

  enum CodingKeys: String, CodingKey {
    case page         = "page"
    case results      = "results"
    case totalPages   = "total_pages"
    case totalResults = "total_results"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    page         = try values.decodeIfPresent(Int.self       , forKey: .page         )
    results      = try values.decodeIfPresent([TrendingThisWeekMovies].self , forKey: .results      )
    totalPages   = try values.decodeIfPresent(Int.self       , forKey: .totalPages   )
    totalResults = try values.decodeIfPresent(Int.self       , forKey: .totalResults )
  }

  init() { }

}

struct TrendingThisWeekMovies: Codable {
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
