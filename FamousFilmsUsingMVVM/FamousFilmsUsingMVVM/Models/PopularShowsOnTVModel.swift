//
//  PopularShowsOnTVModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 16/03/2023.
//

import Foundation
import Foundation

struct PopularShowsOnTVModel: Codable {

  var page         : Int?       = nil
  var results      : [Shows]?   = []
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
    results      = try values.decodeIfPresent([Shows].self   , forKey: .results      )
    totalPages   = try values.decodeIfPresent(Int.self       , forKey: .totalPages   )
    totalResults = try values.decodeIfPresent(Int.self       , forKey: .totalResults )
  }

  init() { }

}

// MARK: - Result
struct Shows: Codable {
  var backdropPath     : String?   = nil
  var firstAirDate     : String?   = nil
  var genreIds         : [Int]?    = []
  var id               : Int?      = nil
  var name             : String?   = nil
  var originCountry    : [String]? = []
  var originalLanguage : String?   = nil
  var originalName     : String?   = nil
  var overview         : String?   = nil
  var popularity       : Double?   = nil
  var posterPath       : String?   = nil
  var voteAverage      : Double?   = nil
  var voteCount        : Int?      = nil

  enum CodingKeys: String, CodingKey {
    case backdropPath     = "backdrop_path"
    case firstAirDate     = "first_air_date"
    case genreIds         = "genre_ids"
    case id               = "id"
    case name             = "name"
    case originCountry    = "origin_country"
    case originalLanguage = "original_language"
    case originalName     = "original_name"
    case overview         = "overview"
    case popularity       = "popularity"
    case posterPath       = "poster_path"
    case voteAverage      = "vote_average"
    case voteCount        = "vote_count"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    backdropPath     = try values.decodeIfPresent(String.self   , forKey: .backdropPath     )
    firstAirDate     = try values.decodeIfPresent(String.self   , forKey: .firstAirDate     )
    genreIds         = try values.decodeIfPresent([Int].self    , forKey: .genreIds         )
    id               = try values.decodeIfPresent(Int.self      , forKey: .id               )
    name             = try values.decodeIfPresent(String.self   , forKey: .name             )
    originCountry    = try values.decodeIfPresent([String].self , forKey: .originCountry    )
    originalLanguage = try values.decodeIfPresent(String.self   , forKey: .originalLanguage )
    originalName     = try values.decodeIfPresent(String.self   , forKey: .originalName     )
    overview         = try values.decodeIfPresent(String.self   , forKey: .overview         )
    popularity       = try values.decodeIfPresent(Double.self   , forKey: .popularity       )
    posterPath       = try values.decodeIfPresent(String.self   , forKey: .posterPath       )
    voteAverage      = try values.decodeIfPresent(Double.self   , forKey: .voteAverage      )
    voteCount        = try values.decodeIfPresent(Int.self      , forKey: .voteCount        )
  }

  init() { }

}
