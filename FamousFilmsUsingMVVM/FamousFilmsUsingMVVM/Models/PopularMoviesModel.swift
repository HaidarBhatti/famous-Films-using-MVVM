//
//  PopularMoviesModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 09/03/2023.
//

import Foundation

struct PopularMoviesModel: Codable {
    let page: Int
    let results: [PopularMovies]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PopularMovies: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguages
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguages: String, Codable {
    case en = "en"
    case es = "es"
    case it = "it"
}



struct PopularStreamingMoviesModel: Codable {
  var page         : Int?       = nil
  var results      : [PopularStreamingMovies]? = []
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
    results      = try values.decodeIfPresent([PopularStreamingMovies].self , forKey: .results      )
    totalPages   = try values.decodeIfPresent(Int.self       , forKey: .totalPages   )
    totalResults = try values.decodeIfPresent(Int.self       , forKey: .totalResults )
  }

  init() { }

}

struct PopularStreamingMovies: Codable {
  var adult            : Bool?   = nil
  var backdropPath     : String? = nil
  var genreIds         : [Int]?  = []
  var id               : Int?    = nil
  var originalLanguage : String? = nil
  var originalTitle    : String? = nil
  var overview         : String? = nil
  var popularity       : Double? = nil
  var posterPath       : String? = nil
  var releaseDate      : String? = nil
  var title            : String? = nil
  var video            : Bool?   = nil
  var voteAverage      : Double? = nil
  var voteCount        : Int?    = nil

  enum CodingKeys: String, CodingKey {
    case adult            = "adult"
    case backdropPath     = "backdrop_path"
    case genreIds         = "genre_ids"
    case id               = "id"
    case originalLanguage = "original_language"
    case originalTitle    = "original_title"
    case overview         = "overview"
    case popularity       = "popularity"
    case posterPath       = "poster_path"
    case releaseDate      = "release_date"
    case title            = "title"
    case video            = "video"
    case voteAverage      = "vote_average"
    case voteCount        = "vote_count"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    adult            = try values.decodeIfPresent(Bool.self   , forKey: .adult            )
    backdropPath     = try values.decodeIfPresent(String.self , forKey: .backdropPath     )
    genreIds         = try values.decodeIfPresent([Int].self  , forKey: .genreIds         )
    id               = try values.decodeIfPresent(Int.self    , forKey: .id               )
    originalLanguage = try values.decodeIfPresent(String.self , forKey: .originalLanguage )
    originalTitle    = try values.decodeIfPresent(String.self , forKey: .originalTitle    )
    overview         = try values.decodeIfPresent(String.self , forKey: .overview         )
    popularity       = try values.decodeIfPresent(Double.self , forKey: .popularity       )
    posterPath       = try values.decodeIfPresent(String.self , forKey: .posterPath       )
    releaseDate      = try values.decodeIfPresent(String.self , forKey: .releaseDate      )
    title            = try values.decodeIfPresent(String.self , forKey: .title            )
    video            = try values.decodeIfPresent(Bool.self   , forKey: .video            )
    voteAverage      = try values.decodeIfPresent(Double.self , forKey: .voteAverage      )
    voteCount        = try values.decodeIfPresent(Int.self    , forKey: .voteCount        )
  }

  init() { }

}
