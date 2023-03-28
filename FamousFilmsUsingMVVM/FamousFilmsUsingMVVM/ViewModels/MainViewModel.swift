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
    var filterTypes: [String]
    var selectedFilter: Int
    var apiType: APIType
}

struct HeaderModel{
    var title: String
    var filterTypes: [String]
    var selectedFilter: Int
}

enum APIType{
    case trending
    case popular
}

class MainViewModel{
    
    var isLoadingHomeData: Observable<Bool> = Observable(false)
    
    var isLoadingPopularMoviesData: Observable<Bool> = Observable(false)    
    
    var trendingDataSource: TrendingMoviesModel?
    var trendingDayDataSource: MovieModelForDays?
    var trendingWeekDataSource: TrendingWeekMoviesModel?
    var popularDataSource: PopularStreamingMoviesModel?
    var popularShowsOnTV: PopularShowsOnTVModel?

    var trendingCollData: [MovieCellData]?
    var popularCollData: [MovieCellData]?
    var popularTVCollData: [Shows]?

    var tableData = [HomeTableModel]()
    
    let group = DispatchGroup()
    
    var segementTapped = false
    var sectionOfCollectionView = 0
    
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
    
    func headerForSection(_ section: Int) -> HeaderModel?{
        return HeaderModel(title: tableData[section].title, filterTypes: tableData[section].filterTypes, selectedFilter: tableData[section].selectedFilter)
    }
    
    func getWeekTrendingData(){
        group.enter()
        APIServices.getWeekTrendingMovies { [weak self] result in
            switch result{
            case .success(let data):
                self?.trendingWeekDataSource = data
                self?.mapTrendingCellData(onCompletion: { result in
                    self?.group.leave()
                })
            case .failure(let error):
                print("error: \(error)")
                self?.group.leave()
            }
        }
    }
    
    func getDayTrendingData(){
        group.enter()
        APIServices.getDayTrendingMovies { [weak self] result in
            switch result{
            case .success(let data):
                self?.trendingDayDataSource = data
                self?.mapDayTrendingCellData(onCompletion: { result in
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
        getDayTrendingData()
        group.wait()
        getPopularData()
        group.wait()
        print("done fetching the data")
        isLoadingHomeData.value = false
    }
    
    func getPopularShowsOnTV(){
        group.enter()
        APIServices.getPopularShowsOnTV { [weak self] result in
            switch result{
            case .success(let data):
                let shows = data.results
                print("\(shows!.count)")
                self?.popularShowsOnTV = data
                self?.mapPopularShowsOnTVData(onCompletion: { result in
                    self?.group.leave()
                })
            case .failure(let error):
                print("error: \(error)")
                self?.group.leave()
            }
        }
    }
    
    func mapTrendingCellData(onCompletion: @escaping (_ result: Bool) -> ()){
        let trendingData = self.trendingWeekDataSource?.results?.compactMap({ MovieCellData(movie: $0) })
        self.trendingCollData = trendingData
        let trending = HomeTableModel(title: "Trending", collData: trendingData, filterTypes: ["Today","This Week"], selectedFilter: 1, apiType: .trending)
        
        if tableData.contains(where: { $0.title == "Trending" }){
            if let index = tableData.firstIndex(where: { $0.title == "Trending" }){
                tableData[index] = trending
            }
        }
        else{
            tableData.append(trending)
        }
        onCompletion(true)
    }
    func mapDayTrendingCellData(onCompletion: @escaping (_ result: Bool) -> ()){
        let trendingData = self.trendingDayDataSource?.results?.compactMap({ MovieCellData(movie: $0) })
        self.trendingCollData = trendingData
        let trending = HomeTableModel(title: "Trending", collData: trendingData, filterTypes: ["Today","This Week"], selectedFilter: 0, apiType: .trending)
        
        if tableData.contains(where: { $0.title == "Trending" }){
            if let index = tableData.firstIndex(where: { $0.title == "Trending" }){
                tableData[index] = trending
            }
        }
        else{
            tableData.append(trending)
        }
        onCompletion(true)
    }
    func mapPopularCellData(onCompletion: @escaping (_ result: Bool) -> ()){
        let popularString = "What's Popular"
        let popularData = self.popularDataSource?.results?.compactMap({ MovieCellData(movie: $0) })
        self.popularCollData = popularData
        let popular = HomeTableModel(title: popularString, collData: popularData, filterTypes: ["Streaming","On TV","In Theatres"], selectedFilter: 0, apiType: .popular)

        if tableData.contains(where: { $0.title == popularString }){
            if let index = tableData.firstIndex(where: { $0.title == popularString }){
                tableData[index] = popular
            }
        }
        else{
            tableData.append(popular)
        }
        onCompletion(true)
    }
    func mapPopularShowsOnTVData(onCompletion: @escaping (_ result: Bool) -> ()){
        let popularString = "What's Popular"
        let popularData = self.popularShowsOnTV?.results?.compactMap({ MovieCellData(shows: $0) })
        self.popularCollData = popularData
        let popular = HomeTableModel(title: popularString, collData: popularData, filterTypes: ["Streaming","On TV","In Theatres"], selectedFilter: 0, apiType: .popular)

        if tableData.contains(where: { $0.title == popularString }){
            if let index = tableData.firstIndex(where: { $0.title == popularString }){
                tableData[index] = popular
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
    
    
    func handleTheTapOnSegment(){
        segementTapped = false
        sectionOfCollectionView = 0
    }
    
}

extension MainViewModel: HeaderViewModelDelegate{
    func didTapButton(with action: String) {
        print(action)
        for headerData in tableData{
            if headerData.filterTypes.contains(action){
                if headerData.apiType == .trending{
                    isLoadingHomeData.value = true
                    if action == "This Week"{
                        getWeekTrendingData()
                    }
                    else if action == "Today"{
                        getDayTrendingData()
                    }
                    group.wait()
                    sectionOfCollectionView = 0
                    segementTapped = true
                    isLoadingHomeData.value = false
                }
                else if headerData.apiType == .popular{
                    isLoadingHomeData.value = true
                    if action == "Streaming"{
                        getPopularData()
                    }
                    else if action == "On TV"{
                        getPopularShowsOnTV()
                    }
                    else if action == "In Theatres"{
                        getPopularData()
                    }
                    group.wait()
                    sectionOfCollectionView = 1
                    segementTapped = true
                    isLoadingHomeData.value = false
                }
            }
        }
    }
}
