//
//  MovieDetailsModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 27/03/2023.
//

import Foundation

struct MovieDetailsModel: Codable {
    var adult               : Bool?                  = nil
    var backdropPath        : String?                = nil
    var belongsToCollection : BelongsToCollection?   = BelongsToCollection()
    var budget              : Int?                   = nil
    var genres              : [Genres]?              = []
    var homepage            : String?                = nil
    var id                  : Int?                   = nil
    var imdbId              : String?                = nil
    var originalLanguage    : String?                = nil
    var originalTitle       : String?                = nil
    var overview            : String?                = nil
    var popularity          : Double?                = nil
    var posterPath          : String?                = nil
    var productionCompanies : [ProductionCompanies]? = []
    var productionCountries : [ProductionCountries]? = []
    var releaseDate         : String?                = nil
    var revenue             : Int?                   = nil
    var runtime             : Int?                   = nil
    var spokenLanguages     : [SpokenLanguages]?     = []
    var status              : String?                = nil
    var tagline             : String?                = nil
    var title               : String?                = nil
    var video               : Bool?                  = nil
    var voteAverage         : Double?                = nil
    var voteCount           : Int?                   = nil
    var credits             : Credits?               = Credits()
    
    var backdropURL         : URL?                = nil
    var posterURL           : URL?                = nil
    
    enum CodingKeys: String, CodingKey {
        case adult               = "adult"
        case backdropPath        = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget              = "budget"
        case genres              = "genres"
        case homepage            = "homepage"
        case id                  = "id"
        case imdbId              = "imdb_id"
        case originalLanguage    = "original_language"
        case originalTitle       = "original_title"
        case overview            = "overview"
        case popularity          = "popularity"
        case posterPath          = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate         = "release_date"
        case revenue             = "revenue"
        case runtime             = "runtime"
        case spokenLanguages     = "spoken_languages"
        case status              = "status"
        case tagline             = "tagline"
        case title               = "title"
        case video               = "video"
        case voteAverage         = "vote_average"
        case voteCount           = "vote_count"
        case credits             = "credits"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult               = try values.decodeIfPresent(Bool.self                  , forKey: .adult               )
        backdropPath        = try values.decodeIfPresent(String.self                , forKey: .backdropPath        )
        belongsToCollection = try values.decodeIfPresent(BelongsToCollection.self   , forKey: .belongsToCollection )
        budget              = try values.decodeIfPresent(Int.self                   , forKey: .budget              )
        genres              = try values.decodeIfPresent([Genres].self              , forKey: .genres              )
        homepage            = try values.decodeIfPresent(String.self                , forKey: .homepage            )
        id                  = try values.decodeIfPresent(Int.self                   , forKey: .id                  )
        imdbId              = try values.decodeIfPresent(String.self                , forKey: .imdbId              )
        originalLanguage    = try values.decodeIfPresent(String.self                , forKey: .originalLanguage    )
        originalTitle       = try values.decodeIfPresent(String.self                , forKey: .originalTitle       )
        overview            = try values.decodeIfPresent(String.self                , forKey: .overview            )
        popularity          = try values.decodeIfPresent(Double.self                , forKey: .popularity          )
        posterPath          = try values.decodeIfPresent(String.self                , forKey: .posterPath          )
        productionCompanies = try values.decodeIfPresent([ProductionCompanies].self , forKey: .productionCompanies )
        productionCountries = try values.decodeIfPresent([ProductionCountries].self , forKey: .productionCountries )
        releaseDate         = try values.decodeIfPresent(String.self                , forKey: .releaseDate         )
        revenue             = try values.decodeIfPresent(Int.self                   , forKey: .revenue             )
        runtime             = try values.decodeIfPresent(Int.self                   , forKey: .runtime             )
        spokenLanguages     = try values.decodeIfPresent([SpokenLanguages].self     , forKey: .spokenLanguages     )
        status              = try values.decodeIfPresent(String.self                , forKey: .status              )
        tagline             = try values.decodeIfPresent(String.self                , forKey: .tagline             )
        title               = try values.decodeIfPresent(String.self                , forKey: .title               )
        video               = try values.decodeIfPresent(Bool.self                  , forKey: .video               )
        voteAverage         = try values.decodeIfPresent(Double.self                , forKey: .voteAverage         )
        voteCount           = try values.decodeIfPresent(Int.self                   , forKey: .voteCount           )
        credits             = try values.decodeIfPresent(Credits.self               , forKey: .credits             )
        
        backdropURL         = makeImageURL(imageLink: backdropPath!)
        posterURL           = makeImageURL(imageLink: posterPath!)
    }
    
    init() { }
    
}

func makeImageURL(imageLink: String) -> URL?{
    return URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageLink)")
}

struct BelongsToCollection: Codable {
    
    var id           : Int?    = nil
    var name         : String? = nil
    var posterPath   : String? = nil
    var backdropPath : String? = nil
    var posterURL    : URL?    = nil
    var backdropURL  : URL?    = nil

    enum CodingKeys: String, CodingKey {
        case id           = "id"
        case name         = "name"
        case posterPath   = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id           = try values.decodeIfPresent(Int.self    , forKey: .id           )
        name         = try values.decodeIfPresent(String.self , forKey: .name         )
        posterPath   = try values.decodeIfPresent(String.self , forKey: .posterPath   )
        backdropPath = try values.decodeIfPresent(String.self , forKey: .backdropPath )
        
        posterURL   = makeImageURL(imageLink: posterPath!)
        backdropURL = makeImageURL(imageLink: backdropPath!)
    }
    
    init() { }
    
    func makeImageURL(imageLink: String) -> URL?{
        return URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageLink)")
    }
    
}

struct Genres: Codable, Equatable {

  var id   : Int?    = nil
  var name : String? = nil

  enum CodingKeys: String, CodingKey {
    case id   = "id"
    case name = "name"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id   = try values.decodeIfPresent(Int.self    , forKey: .id   )
    name = try values.decodeIfPresent(String.self , forKey: .name )
  }

  init() { }

}

struct ProductionCompanies: Codable {

  var id            : Int?    = nil
  var logoPath      : String? = nil
  var name          : String? = nil
  var originCountry : String? = nil

  enum CodingKeys: String, CodingKey {
    case id            = "id"
    case logoPath      = "logo_path"
    case name          = "name"
    case originCountry = "origin_country"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id            = try values.decodeIfPresent(Int.self    , forKey: .id            )
    logoPath      = try values.decodeIfPresent(String.self , forKey: .logoPath      )
    name          = try values.decodeIfPresent(String.self , forKey: .name          )
    originCountry = try values.decodeIfPresent(String.self , forKey: .originCountry )
  }

  init() { }

}

struct ProductionCountries: Codable, Equatable {
    
    var iso      : String? = nil
    var name     : String? = nil
    
    enum CodingKeys: String, CodingKey {
        case iso      = "iso_3166_1"
        case name     = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso        = try values.decodeIfPresent(String.self , forKey: .iso )
        name       = try values.decodeIfPresent(String.self , forKey: .name     )
    }
    
    init() { }
    
}

struct SpokenLanguages: Codable {
  var englishName : String? = nil
  var iso6391     : String? = nil
  var name        : String? = nil

  enum CodingKeys: String, CodingKey {
    case englishName = "english_name"
    case iso6391     = "iso_639_1"
    case name        = "name"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    englishName = try values.decodeIfPresent(String.self , forKey: .englishName )
    iso6391     = try values.decodeIfPresent(String.self , forKey: .iso6391     )
    name        = try values.decodeIfPresent(String.self , forKey: .name        )
  }

  init() { }

}

struct Cast: Codable {
    
    var adult              : Bool?   = nil
    var gender             : Int?    = nil
    var id                 : Int?    = nil
    var knownForDepartment : String? = nil
    var name               : String? = nil
    var originalName       : String? = nil
    var popularity         : Double? = nil
    var profilePath        : String? = nil
    var castId             : Int?    = nil
    var character          : String? = nil
    var creditId           : String? = nil
    var order              : Int?    = nil
    var profilePathURL     : URL?    = nil
    
    enum CodingKeys: String, CodingKey {
        
        case adult              = "adult"
        case gender             = "gender"
        case id                 = "id"
        case knownForDepartment = "known_for_department"
        case name               = "name"
        case originalName       = "original_name"
        case popularity         = "popularity"
        case profilePath        = "profile_path"
        case castId             = "cast_id"
        case character          = "character"
        case creditId           = "credit_id"
        case order              = "order"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        adult              = try values.decodeIfPresent(Bool.self   , forKey: .adult              )
        gender             = try values.decodeIfPresent(Int.self    , forKey: .gender             )
        id                 = try values.decodeIfPresent(Int.self    , forKey: .id                 )
        knownForDepartment = try values.decodeIfPresent(String.self , forKey: .knownForDepartment )
        name               = try values.decodeIfPresent(String.self , forKey: .name               )
        originalName       = try values.decodeIfPresent(String.self , forKey: .originalName       )
        popularity         = try values.decodeIfPresent(Double.self , forKey: .popularity         )
        profilePath        = try values.decodeIfPresent(String.self , forKey: .profilePath        )
        castId             = try values.decodeIfPresent(Int.self    , forKey: .castId             )
        character          = try values.decodeIfPresent(String.self , forKey: .character          )
        creditId           = try values.decodeIfPresent(String.self , forKey: .creditId           )
        order              = try values.decodeIfPresent(Int.self    , forKey: .order              )
        
        if let profilePath = profilePath{
            profilePathURL      = makeImageURL(imageLink: profilePath)
        }
        else{
            profilePathURL      = nil
        }
    }
    
    init() { }
    
}
struct Crew: Codable {

  var adult              : Bool?   = nil
  var gender             : Int?    = nil
  var id                 : Int?    = nil
  var knownForDepartment : String? = nil
  var name               : String? = nil
  var originalName       : String? = nil
  var popularity         : Double? = nil
  var profilePath        : String? = nil
  var creditId           : String? = nil
  var department         : String? = nil
  var job                : String? = nil

  enum CodingKeys: String, CodingKey {

    case adult              = "adult"
    case gender             = "gender"
    case id                 = "id"
    case knownForDepartment = "known_for_department"
    case name               = "name"
    case originalName       = "original_name"
    case popularity         = "popularity"
    case profilePath        = "profile_path"
    case creditId           = "credit_id"
    case department         = "department"
    case job                = "job"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    adult              = try values.decodeIfPresent(Bool.self   , forKey: .adult              )
    gender             = try values.decodeIfPresent(Int.self    , forKey: .gender             )
    id                 = try values.decodeIfPresent(Int.self    , forKey: .id                 )
    knownForDepartment = try values.decodeIfPresent(String.self , forKey: .knownForDepartment )
    name               = try values.decodeIfPresent(String.self , forKey: .name               )
    originalName       = try values.decodeIfPresent(String.self , forKey: .originalName       )
    popularity         = try values.decodeIfPresent(Double.self , forKey: .popularity         )
    profilePath        = try values.decodeIfPresent(String.self , forKey: .profilePath        )
    creditId           = try values.decodeIfPresent(String.self , forKey: .creditId           )
    department         = try values.decodeIfPresent(String.self , forKey: .department         )
    job                = try values.decodeIfPresent(String.self , forKey: .job                )
 
  }

  init() {

  }

}

struct Credits: Codable {

  var cast : [Cast]? = []
  var crew : [Crew]? = []

  enum CodingKeys: String, CodingKey {

    case cast = "cast"
    case crew = "crew"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    cast = try values.decodeIfPresent([Cast].self , forKey: .cast )
    crew = try values.decodeIfPresent([Crew].self , forKey: .crew )
 
  }

  init() {

  }

}
