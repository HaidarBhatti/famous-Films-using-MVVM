//
//  DetailsMovieViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 08/03/2023.
//

import Foundation

class DetailsMovieViewModel{
    
    var movieID: Int
    var detailsScreenTitle = "Movie Details"
    
    var isLoadingMovieDetails: Observable<Bool> = Observable(false)
    var group = DispatchGroup()
    var movieDetails: MovieDetailsModel?
    
    init(movieID: Int){
        self.movieID = movieID
    }
    
    func getMovieDetails(){
        if isLoadingMovieDetails.value ?? true{
            group.leave()
            return
        }
        getPopularData(movieID: movieID)
        group.wait()
        isLoadingMovieDetails.value = false
    }
    
    func getPopularData(movieID: Int){
        group.enter()
        APIServices.getMovieDetails(movieID: movieID) { [weak self] result in
            switch result{
            case .success(let data):
                self?.movieDetails = data
                self?.group.leave()
            case .failure(let error):
                print("error: \(error)")
                self?.group.leave()
            }
        }
    }
    
    func getTime(runtime: Int?) -> String{
        if let time = runtime{
            let hours = time/60
            let minutes = time%60
            return "\(hours)h \(minutes)m"
        }
        return ""
    }
    
    func getProductionCountries(countries: [ProductionCountries]) -> String{
        var string = ""
        for element in countries {
            if element == countries.first {
                string.append("(\((countries.first?.iso!)!),")
            }
            else if element == countries.last {
                string.append("\((countries.last?.iso!)!))")
            }
            else{
                string.append("\(element.iso!), ")
            }
        }
        return string
    }
    
    func getGenres(genres: [Genres]) -> String{
        var genresString = ""
        for element in genres {
            if element == genres.last {
                genresString.append((genres.last?.name!)!)
            }
            else{
                genresString.append("\(element.name!), ")
            }
        }
        return genresString
    }
}
