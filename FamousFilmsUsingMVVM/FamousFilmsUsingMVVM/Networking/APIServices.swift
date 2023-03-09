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
    
    static func getTrendingMovies(mediaType: MediaType, timeWindow: TimeWindow, completionHandler: @escaping (_ result: Result<TrendingMoviesModel,NetworkError>) -> Void ){
        
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
    
    static func getPopularMovies(language: OriginalLanguage, page: Int, completionHandler: @escaping (_ result: Result<PopularMoviesModel,NetworkError>) -> Void ){
        
        let instance = NetworkConstant.shared
        let stringURL = instance.serverAddress+instance.movie+"/\(instance.popular)?"+"\(instance.apiStringWithKey)&\(instance.language)=\(language.rawValue)&\(instance.page)=\(page)"
        
        guard let url = URL(string: stringURL) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil, let data = dataResponse, let resultData = try? JSONDecoder().decode(PopularMoviesModel.self, from: data){
                completionHandler(.success(resultData))
            }
            else{
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
        
}
