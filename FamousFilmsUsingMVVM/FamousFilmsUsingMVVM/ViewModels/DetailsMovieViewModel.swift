//
//  DetailsMovieViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 08/03/2023.
//

import Foundation

class DetailsMovieViewModel{
    
    var movie: MovieCellData
    var detailsScreenTitle = "Movie Details"
    
    init(movie: MovieCellData){
        self.movie = movie
    }
}
