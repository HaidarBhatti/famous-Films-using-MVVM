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
    
}
