//
//  MainViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import Foundation

struct HomeTableModel{
    var title: String
    var collData: [MovieCellData]?
}

class MainViewModel{
    
    var isLoadingHomeData: Observable<Bool> = Observable(false)
    
    var trendingDataSource: TrendingMoviesModel?
    var popularDataSource: PopularMoviesModel?

    var trendingCollData: [MovieCellData]?
    var popularCollData: [MovieCellData]?

    var tableData = [HomeTableModel]()
    
    func noOfSections() -> Int{
        return tableData.count
    }
    
    func numberOfRows(in section: Int) -> Int{
        return tableData.count
    }
    
    func cellForRowAt(in section: Int) -> [MovieCellData]?{
        guard let cellData = tableData[section].collData else {
            return nil
        }
        return cellData
    }
    
    func getHomeScreenData(){
        let group = DispatchGroup()
        group.enter()
        
        if isLoadingHomeData.value ?? true{
            group.leave()
            return
        }
        isLoadingHomeData.value = true
        APIServices.getTrendingMovies(mediaType: .all, timeWindow: .day) { [weak self] result in
            switch result{
            case .success(let data):
                self?.trendingDataSource = data
                self?.mapTrendingCellData(onCompletion: { result in
                    group.leave()
                })
            case .failure(let error):
                print("error: \(error)")
                group.leave()
            }
        }
        
        group.enter()
        APIServices.getPopularMovies(language: .en, page: 1) { [weak self] result in
            switch result{
            case .success(let data):
                self?.popularDataSource = data
                self?.mapPopularCellData(onCompletion: { result in
                    group.leave()
                })
            case .failure(let error):
                print("error: \(error)")
                group.leave()
            }
        }
        
        group.wait()
        print("done fetching the data")
        self.isLoadingHomeData.value = false
    }
    
    
    func getTrendingData(){
        getHomeScreenData()
    }
    
    func mapTrendingCellData(onCompletion: @escaping (_ result: Bool) -> ()){
        let trendingData = self.trendingDataSource?.results.compactMap({ MovieCellData(movie: $0) })
        self.trendingCollData = trendingData
        tableData.append(HomeTableModel(title: "Trending", collData: trendingData))
        onCompletion(true)
    }
    func mapPopularCellData(onCompletion: @escaping (_ result: Bool) -> ()){
        let popularData = self.popularDataSource?.results.compactMap({ MovieCellData(movie: $0) })
        self.popularCollData = popularData
        tableData.append(HomeTableModel(title: "Popular", collData: popularData))
        onCompletion(true)
    }
    
    func retrieveMovie( withId id: Int) -> TrendingMovies? {
        guard let movie = trendingDataSource?.results.first(where: { $0.id == id }) else { return nil }
        return movie
    }
    func retrieveTrendingMovie(withId id: Int) -> MovieCellData? {
        guard let movie = trendingCollData?.first(where: { $0.id == id }) else { return nil }
        return movie
    }
    
}
