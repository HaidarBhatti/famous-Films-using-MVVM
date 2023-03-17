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
    var voteAverage: Double
    var movieImageURL: URL?
    var overview: String
    
    init(movie: TrendingMovies){
        id = movie.id
        movieTitle = movie.title
        movieReleaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        movieImageURL = makeImageURL(imageLink: movie.posterPath)
    }
    
    init(movie: MovieDayModel){
        id = movie.id
        movieTitle = movie.title
        movieReleaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        movieImageURL = makeImageURL(imageLink: movie.posterPath)
    }
    
    init(movie: PopularMovies){
        id = movie.id
        movieTitle = movie.title 
        movieReleaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        movieImageURL = makeImageURL(imageLink: movie.posterPath)
    }
    
    func makeImageURL(imageLink: String) -> URL?{
        return URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageLink)")
    }
    
}
