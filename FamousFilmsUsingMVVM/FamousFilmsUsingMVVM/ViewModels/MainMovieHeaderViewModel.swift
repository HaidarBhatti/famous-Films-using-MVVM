//
//  MainMovieHeaderViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 17/03/2023.
//

import Foundation

class MainMovieHeaderViewModel{
    var headerData: HeaderModel
    var mainViewModel = MainViewModel()
    var delegate: HeaderViewModelDelegate?
    
    init(headerData: HeaderModel){
        self.headerData = headerData
    }
    
    func numberOfSegments() -> Int{
        headerData.filterTypes.count
    }
    
    func titleForSegmentAt(index: Int) -> String{
        headerData.filterTypes[index]
    }
    
    func selectedSegmentIndex() -> Int{
        return headerData.selectedFilter
    }
}
