//
//  APIServices.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import Foundation

enum NetworkError: Error{
    case urlError
    case canNotParseData
}


class APIServices{
    
    static func getDayTrendingMovies(mediaType: MediaType = .movie, timeWindow: TimeWindow = .day, completionHandler: @escaping (_ result: Result<MovieModelForDays,NetworkError>) -> Void ){
        
        let instance = NetworkConstant.shared
        let stringURL = instance.serverAddress+instance.trending+"\(mediaType.rawValue)/"+"\(timeWindow.rawValue)?\(instance.apiStringWithKey)"
        
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(MovieModelForDays.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getWeekTrendingMovies(mediaType: MediaType = .movie, timeWindow: TimeWindow = .week, completionHandler: @escaping (_ result: Result<TrendingWeekMoviesModel,NetworkError>) -> Void ){
        
        let instance = NetworkConstant.shared
        let stringURL = instance.serverAddress+instance.trending+"\(mediaType.rawValue)/"+"\(timeWindow.rawValue)?\(instance.apiStringWithKey)"
        
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(TrendingWeekMoviesModel.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getPopularMovies(language: OriginalLanguage, page: Int, completionHandler: @escaping (_ result: Result<PopularStreamingMoviesModel,NetworkError>) -> Void ){
        
        let instance = NetworkConstant.shared
        let stringURL = instance.serverAddress+instance.movie+"/\(instance.popular)?"+"\(instance.apiStringWithKey)&\(instance.language)=\(language.rawValue)&\(instance.page)=\(page)"
        
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(PopularStreamingMoviesModel.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    
    static func getPopularShowsOnTV(completionHandler: @escaping (_ result: Result<PopularShowsOnTVModel,NetworkError>) -> Void ){
        let stringURL = "https://api.themoviedb.org/3/tv/popular?api_key=d1d27f2bf81b0d3c9bfe65fb90485381"
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(PopularShowsOnTVModel.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getMovies(mediaType: MediaType, timeWindow: TimeWindow, completionHandler: @escaping (_ result: Result<TrendingMoviesModel,NetworkError>) -> Void ){
        
        let instance = NetworkConstant.shared
        let stringURL = instance.serverAddress+instance.trending+"\(mediaType.rawValue)/"+"\(timeWindow.rawValue)?\(instance.apiStringWithKey)"
        
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(TrendingMoviesModel.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
        
}

//MARK: - This extension will get the data for the DetailsMovieViewController
extension APIServices{
    static func getMovieDetails(movieID: Int, completionHandler: @escaping (_ result: Result<MovieDetailsModel, NetworkError>) -> Void ){
        let instance = NetworkConstant.shared
        let stringURL = instance.serverAddress+instance.movie+"/\(movieID)?\(instance.apiStringWithKey)&append_to_response=credits"
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(MovieDetailsModel.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}

//MARK: - This extension will get the data for the DetailsPersonViewController
extension APIServices{
    static func getPersonDetails(personID: Int, completionHandler: @escaping (_ result: Result<PersonDetailsModel, NetworkError>) -> Void ){
        let instance = NetworkConstant.shared
        let stringURL = instance.serverAddress+instance.person+"/\(personID)?\(instance.apiStringWithKey)"
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(PersonDetailsModel.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getMoviesForPerson(withID personID: Int, completionHandler: @escaping (_ result: Result<MoviesForPersonModel, NetworkError>) -> Void ){
        
//    https://api.themoviedb.org/3/person/4491/movie_credits?api_key=d1d27f2bf81b0d3c9bfe65fb90485381
        let instance = NetworkConstant.shared
        let stringURL = instance.serverAddress+instance.person+"/\(personID)/\(instance.movieCredits)?\(instance.apiStringWithKey)"
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(MoviesForPersonModel.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
