//
//  DetailsMovieViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 08/03/2023.
//

import Foundation

class DetailsMovieViewModel{
    
    var movie: Movie
    
    var movieID: Int
    var movieTitle: String
    var movieDescription: String
    var movieImage: URL?
    
    var detailsScreenTitle = "Movie Details"
    
    init(movie: Movie){
        self.movie = movie
        
        movieID = movie.id
        movieTitle = movie.title ?? movie.name ?? ""
        movieDescription = movie.overview
        movieImage = makeImageURL(imageAddress: movie.backdropPath)
    }
    
    func makeImageURL(imageAddress: String) -> URL?{
        return URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageAddress)")
    }
}
