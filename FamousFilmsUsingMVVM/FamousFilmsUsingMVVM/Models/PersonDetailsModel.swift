//
//  PersonDetailsModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 01/04/2023.
//

import Foundation

struct PersonDetailsModel: Codable {
    var adult              : Bool?     = nil
    var alsoKnownAs        : [String]? = []
    var biography          : String?   = nil
    var birthday           : String?   = nil
    var deathday           : String?   = nil
    var gender             : Int?      = nil
    var homepage           : String?   = nil
    var id                 : Int?      = nil
    var imdbId             : String?   = nil
    var knownForDepartment : String?   = nil
    var name               : String?   = nil
    var placeOfBirth       : String?   = nil
    var popularity         : Double?   = nil
    var profilePath        : String?   = nil
    
    var profileImage       : URL?
    
    enum CodingKeys: String, CodingKey {
        case adult              = "adult"
        case alsoKnownAs        = "also_known_as"
        case biography          = "biography"
        case birthday           = "birthday"
        case deathday           = "deathday"
        case gender             = "gender"
        case homepage           = "homepage"
        case id                 = "id"
        case imdbId             = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name               = "name"
        case placeOfBirth       = "place_of_birth"
        case popularity         = "popularity"
        case profilePath        = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult              = try values.decodeIfPresent(Bool.self     , forKey: .adult              )
        alsoKnownAs        = try values.decodeIfPresent([String].self , forKey: .alsoKnownAs        )
        biography          = try values.decodeIfPresent(String.self   , forKey: .biography          )
        birthday           = try values.decodeIfPresent(String.self   , forKey: .birthday           )
        deathday           = try values.decodeIfPresent(String.self   , forKey: .deathday           )
        gender             = try values.decodeIfPresent(Int.self      , forKey: .gender             )
        homepage           = try values.decodeIfPresent(String.self   , forKey: .homepage           )
        id                 = try values.decodeIfPresent(Int.self      , forKey: .id                 )
        imdbId             = try values.decodeIfPresent(String.self   , forKey: .imdbId             )
        knownForDepartment = try values.decodeIfPresent(String.self   , forKey: .knownForDepartment )
        name               = try values.decodeIfPresent(String.self   , forKey: .name               )
        placeOfBirth       = try values.decodeIfPresent(String.self   , forKey: .placeOfBirth       )
        popularity         = try values.decodeIfPresent(Double.self   , forKey: .popularity         )
        profilePath        = try values.decodeIfPresent(String.self   , forKey: .profilePath        )
        
        if let link = profilePath{
            profileImage       = makeImageURL(imageLink: link)
        }
        else{
            profileImage       = nil
        }
    }
    
    init() { }
    
}
