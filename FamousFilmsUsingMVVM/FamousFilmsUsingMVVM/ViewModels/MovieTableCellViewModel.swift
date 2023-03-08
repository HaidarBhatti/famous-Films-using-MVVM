//
//  MovieTableCellViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 08/03/2023.
//

import Foundation

class MovieTableCellViewModel{
    
    var id: Int
    var title: String
    var date: String
    var ratings: String
    var imageURL: URL?
    
    init(movie: Movie){
        id = movie.id
        title = movie.title ?? movie.name ?? ""
        date = movie.releaseDate ?? movie.firstAirDate ?? ""
        ratings = "\(movie.voteAverage)/10"
        imageURL = makeImageURL(movie.posterPath)
    }
    
    func makeImageURL(_ imageCode: String) -> URL?{
        return URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageCode)")
    }
}
