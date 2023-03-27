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
    var movieBackdropPathImageURL: URL?
    
    init(movie: TrendingMovies){
        id = movie.id
        movieTitle = movie.title
        movieReleaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        movieImageURL = makeImageURL(imageLink: movie.posterPath)
        movieBackdropPathImageURL = makeImageURL(imageLink: movie.backdropPath)
    }
    
    init(movie: MovieForDay){
        id = movie.id!
        movieTitle = movie.title!
        movieReleaseDate = movie.releaseDate!
        voteAverage = movie.voteAverage!
        overview = movie.overview!
        movieImageURL = makeImageURL(imageLink: movie.posterPath!)
        movieBackdropPathImageURL = makeImageURL(imageLink: movie.backdropPath!)
    }
    
    init(movie: PopularMovies){
        id = movie.id
        movieTitle = movie.title 
        movieReleaseDate = movie.releaseDate
        voteAverage = movie.voteAverage
        overview = movie.overview
        movieImageURL = makeImageURL(imageLink: movie.posterPath)
        movieBackdropPathImageURL = makeImageURL(imageLink: movie.backdropPath)
    }
    
    func makeImageURL(imageLink: String) -> URL?{
        return URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageLink)")
    }
    
}
