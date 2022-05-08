//
//  APIService.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 01/05/22.
//

import Foundation

class APIService {
    private var dataTask : URLSessionDataTask?
    private var apiKey = "8908a1d59ebed18e66c34b99f01d57fc"
    private var url = "https://api.themoviedb.org/3/movie/"
    func getData(preferences : String, page : Int, language : String, completion : @escaping (Result<MoviesModel, Error>) -> Void) {
        let moviesURL = "\(url)\(preferences)?api_key=\(apiKey)&language=\(language)&page=\(page)"
        let newUrl = moviesURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        guard let url = URL(string: newUrl!) else {return }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code : \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(MoviesModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    func getDetailData(idMovie: Int, language : String, completion : @escaping (Result<MoviesDetailModel, Error>) -> Void) {
        let detailURL = "\(url)\(idMovie)?api_key=\(apiKey)&language=\(language)"
        guard let url = URL(string: detailURL) else {return }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code : \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(MoviesDetailModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    
    func getReviewsData(idMovie: Int, completion : @escaping (Result<MoviesReviewsModel, Error>) -> Void) {
        let reviewUrl = "\(url)\(idMovie)/reviews?api_key=\(apiKey)"
        guard let url = URL(string: reviewUrl) else {return }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("DataTask Error : \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code : \(response.statusCode)")
            guard let data = data else {
                print("Empty Data")
                return
            }
            do {
                let decode = JSONDecoder()
                let jsonData = try decode.decode(MoviesReviewsModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
