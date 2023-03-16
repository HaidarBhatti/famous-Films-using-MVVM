//
//  MainViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import UIKit

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
    
    let group = DispatchGroup()
    
    public var title: String{
        get{
            return "Home"
        }
    }
    
    func getCellHeight() -> CGFloat{
        return 300.0
    }
    
    func noOfSections() -> Int{
        return tableData.count
    }
    
    func numberOfRows(in section: Int) -> Int{
        return 1
    }
    
    func cellForRowAt(in section: Int) -> [MovieCellData]?{
        guard let cellData = tableData[section].collData else {
            return nil
        }
        return cellData
    }
    
    func  headerForSection(_ section: Int) -> String?{
        return tableData[section].title
    }
    
    func getTrendingData(mediaType: MediaType = .movie, timeWindow: TimeWindow = .week){
        group.enter()
        APIServices.getTrendingMovies(mediaType: mediaType, timeWindow: timeWindow) { [weak self] result in
            switch result{
            case .success(let data):
                self?.trendingDataSource = data
                self?.mapTrendingCellData(onCompletion: { result in
                    self?.group.leave()
                })
            case .failure(let error):
                print("error: \(error)")
                self?.group.leave()
            }
        }
    }
    func getPopularData(){
        group.enter()
        APIServices.getPopularMovies(language: .en, page: 1) { [weak self] result in
            switch result{
            case .success(let data):
                self?.popularDataSource = data
                self?.mapPopularCellData(onCompletion: { result in
                    self?.group.leave()
                })
            case .failure(let error):
                print("error: \(error)")
                self?.group.leave()
            }
        }
    }
    
    func getHomeScreenData(){
        if isLoadingHomeData.value ?? true{
            group.leave()
            return
        }
        isLoadingHomeData.value = true
        getTrendingData()
        group.wait()
        getPopularData()
        group.wait()
        print("done fetching the data")
        isLoadingHomeData.value = false
    }
    
    func mapTrendingCellData(onCompletion: @escaping (_ result: Bool) -> ()){
        let trendingData = self.trendingDataSource?.results.compactMap({ MovieCellData(movie: $0) })
        self.trendingCollData = trendingData
        let trending = HomeTableModel(title: "Trending", collData: trendingData)
        
        if tableData.contains(where: { $0.title == "Trending" }){
            if let index = tableData.firstIndex(where: { $0.title == "Trending" }){
                tableData.insert(trending, at: index)
            }
        }
        else{
            tableData.append(trending)
        }
        onCompletion(true)
    }
    func mapPopularCellData(onCompletion: @escaping (_ result: Bool) -> ()){
        let popularData = self.popularDataSource?.results.compactMap({ MovieCellData(movie: $0) })
        self.popularCollData = popularData
        let popular = HomeTableModel(title: "Popular", collData: popularData)
        
        if tableData.contains(where: { $0.title == "Popular" }){
            if let index = tableData.firstIndex(where: { $0.title == "Popular" }){
                tableData.insert(popular, at: index)
            }
        }
        else{
            tableData.append(popular)
        }
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
