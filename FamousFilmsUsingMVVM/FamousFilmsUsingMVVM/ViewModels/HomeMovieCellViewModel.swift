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
    
    init(movie: PopularStreamingMovies){
        id = movie.id!
        movieTitle = movie.title!
        movieReleaseDate = movie.releaseDate ?? ""
        voteAverage = movie.voteAverage!
        overview = movie.overview!
        movieImageURL = makeImageURL(imageLink: movie.posterPath!)
        if let url = movie.backdropPath{
            movieBackdropPathImageURL = makeImageURL(imageLink: url)
        }
        else{
            movieBackdropPathImageURL = nil
        }
    }
    
    init(movie: TrendingThisWeekMovies){
        id = movie.id!
        movieTitle = movie.title!
        movieReleaseDate = movie.releaseDate!
        voteAverage = movie.voteAverage!
        overview = movie.overview!
        movieImageURL = makeImageURL(imageLink: movie.posterPath!)
        movieBackdropPathImageURL = makeImageURL(imageLink: movie.backdropPath!)
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
    
    init(shows: Shows){
        id = shows.id!
        movieTitle = shows.name ?? shows.originalName ?? ""
        movieReleaseDate = shows.firstAirDate!
        voteAverage = shows.voteAverage!
        overview = shows.overview!
        movieImageURL = makeImageURL(imageLink: shows.posterPath ?? shows.backdropPath ?? "")
        movieBackdropPathImageURL = makeImageURL(imageLink: shows.backdropPath ?? shows.posterPath ?? "")
    }
    
    func makeImageURL(imageLink: String) -> URL?{
        return URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageLink)")
    }
    
}
