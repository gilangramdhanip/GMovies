//
//  MovieCoreDataTests.swift
//  GMoviesTests
//
//  Created by Gilang Ramdhani Putra on 08/05/22.
//

import XCTest
import CoreData
@testable import GMovies

class MovieCoreDataTests: XCTestCase {
    
    var service: PersitanceManager!
    
    override func setUp() {
      super.setUp()
        service = PersitanceManager()
    }
    
    override func tearDown() {
      super.tearDown()
        service = nil
    }
    
    func testAddMovie() {
        
        let movies = Movie(adult: false, backdropPath: "", genreIDS: [3], id: 1, originalLanguage: "en-US", originalTitle: "KitaBisa", overview: "hei", popularity: 1000, posterPath: "https://image.tmdb.org/t/p/w500/kuxjMVuc3VTD7p42TZpJNsSrM1V.jpg", releaseDate: "2022-06-15", title: "Kitabisa.com", video: false, voteAverage: 5.0, voteCount: 1000)

        XCTAssertNotNil(movies, "Movie should not be nil")
        XCTAssertTrue(movies.title == "Kitabisa.com")
        XCTAssertTrue(movies.overview == "hei")
        XCTAssertTrue(movies.id == 1)
        XCTAssertTrue(movies.posterPath == "https://image.tmdb.org/t/p/w500/kuxjMVuc3VTD7p42TZpJNsSrM1V.jpg")
        XCTAssertTrue(movies.releaseDate == "2022-06-15")
        XCTAssertTrue(movies.voteAverage == 5.0)
        XCTAssertTrue(movies.voteCount == 1000)
        XCTAssertNotNil(movies.id, "id should not be nil")
        XCTAssertNotNil(movies.releaseDate, "releaseDate should not be nil")
    }
    
    func testGetMovie() {
        
        let movies = Movies(context: service.persistentContainer.viewContext)
        movies.title = "Kitabisa"
        movies.posterPath = ""
        movies.overview = "hei"
        movies.releaseDate = "2022-06-15"
        movies.voteAverage = 5.0
        movies.voteCount = 1000
        movies.isFavorite = true
        
        let getMovies = service.fetchFavoriteMovie()
        XCTAssertNotNil(getMovies)
        XCTAssertTrue(getMovies.count == 1)
        XCTAssertTrue(movies.id == getMovies.first?.id)
    }
    
    func testDeleteMovie() {
        
        let movies = Movies(context: service.persistentContainer.viewContext)
        movies.title = "Kitabisa"
        movies.posterPath = ""
        movies.overview = "hei"
        movies.releaseDate = "2022-06-15"
        movies.voteAverage = 5.0
        movies.voteCount = 1000
        movies.isFavorite = true
        
        var getMovies = service.fetchFavoriteMovie()
        XCTAssertTrue(getMovies.count == 1)
        XCTAssertTrue(movies.id == getMovies.first?.id)
        
        service.unFavoriteMovies(movies: movies)
        getMovies = service.fetchFavoriteMovie()
        
        XCTAssertTrue(getMovies.isEmpty)
        
      }



}
