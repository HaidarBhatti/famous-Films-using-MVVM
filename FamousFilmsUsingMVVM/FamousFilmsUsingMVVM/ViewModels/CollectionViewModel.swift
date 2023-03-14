//
//  CollectionViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 09/03/2023.
//

import Foundation

class CollectionViewModel{
    
    var trendingCollData: [MovieCellData] = []
    
    init(trendingCollData: [MovieCellData]){
        self.trendingCollData = trendingCollData
    }
    
    func retrieveMovie(with id: Int) -> MovieCellData?{
        guard let movie = self.trendingCollData.first(where: { $0.id == id }) else { return nil }
        return movie
    }
    
}
