//
//  MoviesForPersonModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 02/04/2023.
//

import Foundation

struct MoviesForPersonModel: Codable {
    
    var cast : [CastForMovie]? = []
    var crew : [CrewForMovie]? = []
    var id   : Int?    = nil
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
        case crew = "crew"
        case id   = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cast = try values.decodeIfPresent([CastForMovie].self , forKey: .cast )
        crew = try values.decodeIfPresent([CrewForMovie].self , forKey: .crew )
        id   = try values.decodeIfPresent(Int.self    , forKey: .id   )
    }
    
    init() { }
    
}

struct CrewForMovie: Codable {
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
    var creditId         : String? = nil
    var department       : String? = nil
    var job              : String? = nil
    
    var backdropImagePath: URL? = nil
    var posterImagePath  : URL? = nil
    
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
        case creditId         = "credit_id"
        case department       = "department"
        case job              = "job"
        
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
        creditId         = try values.decodeIfPresent(String.self , forKey: .creditId         )
        department       = try values.decodeIfPresent(String.self , forKey: .department       )
        job              = try values.decodeIfPresent(String.self , forKey: .job              )
        
        backdropImagePath = nil
        if backdropPath != nil{
            backdropImagePath = makeImageURL(imageLink: backdropPath!)
        }
        
        posterImagePath = nil
        if posterPath != nil{
            posterImagePath = makeImageURL(imageLink: posterPath!)
        }
    }
    
    init() { }
}

struct CastForMovie: Codable {

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
  var character        : String? = nil
  var creditId         : String? = nil
  var order            : Int?    = nil
    
    var backdropImagePath: URL? = nil
    var posterImagePath: URL? = nil

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
    case character        = "character"
    case creditId         = "credit_id"
    case order            = "order"
  
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
    character        = try values.decodeIfPresent(String.self , forKey: .character        )
    creditId         = try values.decodeIfPresent(String.self , forKey: .creditId         )
    order            = try values.decodeIfPresent(Int.self    , forKey: .order            )
 
      if backdropPath != nil{
          backdropImagePath = makeImageURL(imageLink: backdropPath!)
      }
      
      if posterPath != nil{
          posterImagePath = makeImageURL(imageLink: posterPath!)
      }
  }

  init() {

  }

}
