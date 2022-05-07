//
//  MoviesViewModel.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 01/05/22.
//

import Foundation

class MoviesViewModel {
    private var apiService = APIService()
    private var movies = [Movie]()
    var isLoading: Bool = false
    private var filtered: [String]!
    
    func fetchMovieData(preferences: String, page : Int, language : String, completion: @escaping (MoviesModel) -> Void) {
        apiService.getData(preferences: preferences, page: page, language: language) { [ weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.isLoading = false
                self?.movies = listOf.results
                completion(listOf)
            case.failure(let error):
                self?.isLoading = true
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if movies.count != 0 {
            return movies.count
        }
        return 0
    }
    func cellForRowAt (indexPath : IndexPath) -> Movie {
        return movies[indexPath.row]
    }
}
