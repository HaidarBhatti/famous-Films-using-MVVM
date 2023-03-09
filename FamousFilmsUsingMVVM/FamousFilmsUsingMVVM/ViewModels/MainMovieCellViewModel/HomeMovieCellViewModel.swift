//
//  yuio.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 08/03/2023.
//

import Foundation


class MovieCellData{
            
    var id: Int
    var movieTitle: String
    var movieReleaseDate: String
    var popularity: Double
    var movieImageURL: URL?
    
    init(movie: TrendingMovies){
        id = movie.id
        movieTitle = movie.name ?? movie.title ?? ""
        movieReleaseDate = movie.releaseDate ?? movie.firstAirDate ?? ""
        popularity = movie.popularity
        movieImageURL = makeImageURL(imageLink: movie.posterPath)
    }
    
    func makeImageURL(imageLink: String) -> URL?{
        return URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageLink)")
    }
    
}
