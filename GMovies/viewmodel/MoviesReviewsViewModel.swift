//
//  MoviesReviewsViewModel.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 08/05/22.
//

import Foundation

class MoviesReviewsViewModel {
    
    private var apiService = APIService()
    private var moviesReview = [Review]()
    var isLoading: Bool = false
    private var filtered: [String]!
    
    func fetchMovieReview(idMovie : Int, completion: @escaping (MoviesReviewsModel) -> Void) {
        apiService.getReviewsData(idMovie: idMovie) { [ weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.isLoading = false
                self?.moviesReview = listOf.results
                completion(listOf)
            case.failure(let error):
                self?.isLoading = true
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if moviesReview.count != 0 {
            return moviesReview.count
        }
        return 0
    }
    func cellForRowAt (indexPath : IndexPath) -> Review {
        return moviesReview[indexPath.row]
    }
}
