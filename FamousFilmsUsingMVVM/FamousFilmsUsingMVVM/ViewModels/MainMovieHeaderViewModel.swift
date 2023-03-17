//
//  MainMovieHeaderViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 17/03/2023.
//

import Foundation

class MainMovieHeaderViewModel{
    var headerData = [String]()
    var title: String
    
    var mainViewModel = MainViewModel()
    
    weak var delegate: HeaderViewModelDelegate?
    
    init(headerData: [String], title: String){
        self.headerData = headerData
        self.title = title
    }
    
    func numberOfSegments() -> Int{
        headerData.count
    }
    
    func titleForSegmentAt(index: Int) -> String{
        headerData[index]
    }
}
