//
//  MainViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import Foundation

class MainViewModel{
    
    var isLoadingTrendingMovies: Observable<Bool> = Observable(false)
    var isLoadingPopularMovies: Observable<Bool> = Observable(false)
    
    var dataSource: TrendingMoviesModel?
    var trendingCollData: [MainMovieCellViewModel]?
    
    func noOfSections() -> Int{
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int{
        return 1
    }
    
    func cellForRowAt() -> [MainMovieCellViewModel]?{
        guard let trendingCollData = trendingCollData else {
            return nil
        }
        return trendingCollData
    }
    
    func getTrendingData(){
        if isLoadingTrendingMovies.value ?? true{
            return
        }
        isLoadingTrendingMovies.value = true
        APIServices.getTrendingMovies(mediaType: .all, timeWindow: .day) { [weak self] result in
            self?.isLoadingTrendingMovies.value = false
            switch result{
            case .success(let data):
                self?.dataSource = data
                self?.mapTrendingCellData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
//        getPopularMoviesData()
    }
    
    func getPopularMoviesData(){
        if isLoadingPopularMovies.value ?? true{
            return
        }
        isLoadingPopularMovies.value = true
        APIServices.getPopularMovies(language: .en, page: 1) { [weak self] result in
            self?.isLoadingPopularMovies.value = false
            switch result{
            case .success(let data):
                print("data.count \(data.results.count)")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    func mapTrendingCellData(){
        self.trendingCollData = self.dataSource?.results.compactMap({ MainMovieCellViewModel(movie: $0) })
    }
    
    func retrieveMovie( withId id: Int) -> TrendingMovies? {
        guard let movie = dataSource?.results.first(where: { $0.id == id }) else { return nil }
        return movie
    }
    func retrieveTrendingMovie(withId id: Int) -> MainMovieCellViewModel? {
        guard let movie = trendingCollData?.first(where: { $0.id == id }) else { return nil }
        return movie
    }
    
}
