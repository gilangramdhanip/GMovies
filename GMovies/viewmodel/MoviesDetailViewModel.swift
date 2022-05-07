//
//  MoviesDetailViewModel.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 06/05/22.
//

import Foundation

class MoviesDetailViewModel {
    private var apiService = APIService()
    var isLoading: Bool = false
    func fetchDetailMovieData(idMovies: Int, language : String, completion: @escaping (MoviesDetailModel) -> Void) {
        apiService.getDetailData(idMovie: idMovies, language: language) { [ weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.isLoading = false
                completion(listOf)
            case.failure(let error):
                self?.isLoading = true
                print("Error processing json data: \(error)")
            }
        }
    }
}
