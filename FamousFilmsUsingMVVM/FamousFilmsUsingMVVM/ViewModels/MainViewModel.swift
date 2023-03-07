//
//  MainViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import Foundation

class MainViewModel{
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[Movie]> = Observable(nil)
    var dataSource: TrendingMoviesModel?
    
    func noOfSections() -> Int{
        1
    }
    
    func numberOfRows(in section: Int) -> Int{
        return dataSource?.results.count ?? 0
    }
    
    func getMovieName(in row: Int) -> String{
        guard let movieData = dataSource?.results[row] else { return ""}
        return movieData.name ?? movieData.title ?? ""
    }
    
    func getTrendingData(){
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        APIServices.getTrendingMovies(mediaType: .all, timeWindow: .day) { [weak self] result in
            self?.isLoading.value = false
            switch result{
            case .success(let data):
                self?.dataSource = data
                self?.mapCellData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func mapCellData(){
        self.cellDataSource.value = self.dataSource?.results
    }
    
}
