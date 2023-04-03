//
//  DetailsPersonViewModel.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 01/04/2023.
//

import Foundation

class DetailsPersonViewModel{
    
    var personID: Int
    var screenTitle = "Person Details"
    
    var isLoadingPersonDetails: Observable<Bool> = Observable(false)
    var group = DispatchGroup()
    var personDetails: PersonDetailsModel?
    var personCastedInMovies : MoviesForPersonModel?
    
    init(personID: Int){
        self.personID = personID
    }
    
    func getPersonDetails(){
        if isLoadingPersonDetails.value ?? true{
            group.leave()
            return
        }
        getPerson(withID: personID)
        group.wait()
        getAllMoviesRelatedToPerson(withID: personID)
        group.wait()
        isLoadingPersonDetails.value = false
    }
    
    private func getPerson(withID id: Int){
        group.enter()
        APIServices.getPersonDetails(personID: id) { [weak self] result in
            switch result{
            case .success(let data):
                self?.personDetails = data
                self?.group.leave()
            case .failure(let error):
                print("error: \(error)")
                self?.group.leave()
            }
        }
    }
    
    func getAllMoviesRelatedToPerson(withID id: Int){
        group.enter()
        APIServices.getMoviesForPerson(withID: id) { [weak self] result in
            switch result{
            case .success(let data):
                self?.personCastedInMovies = data
                self?.group.leave()
            case .failure(let error):
                print("error: \(error)")
                self?.group.leave()
            }
        }
    }
    
    func numberOfItems() -> Int{
        return 10
    }
    
    func cellFor(item: Int) -> CastForMovie?{
        if let sortedMovies = sortAndReturnFirstTenMovies(){
            return sortedMovies[item]
        }
        return nil
    }
    
    func sortAndReturnFirstTenMovies() -> [CastForMovie]?{
        if let movies = self.personCastedInMovies?.cast{
            var sortedMovies = movies
            sortedMovies = sortedMovies.sorted { $0.popularity! > $1.popularity! }
            return sortedMovies
        }
        else{
            return nil
        }
    }
    
    
}
