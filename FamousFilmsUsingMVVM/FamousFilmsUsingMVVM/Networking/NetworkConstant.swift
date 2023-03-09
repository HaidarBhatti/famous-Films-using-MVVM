//
//  NetworkConstant.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import Foundation

class NetworkConstant{
    
    public static var shared = NetworkConstant()
    
    private init(){}
        
    public var apiStringWithKey: String{
        get{
            return "api_key=\(apiKey)"
        }
    }
    public var apiKey: String{
        get{
            return "d1d27f2bf81b0d3c9bfe65fb90485381"
        }
    }
    public var serverAddress: String{
        get{
            return "https://api.themoviedb.org/3/"
        }
    }
    public var imageServerAddress: String{
        get{
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
    
    public var trending: String{
        get{
            return "trending/"
        }
    }
    public var popular: String{
        get{
            return "popular"
        }
    }
    public var movie: String{
        get{
            return "movie"
        }
    }
    public var language: String{
        get{
            return "language"
        }
    }
    public var page: String{
        get{
            return "page"
        }
    }
        
}
