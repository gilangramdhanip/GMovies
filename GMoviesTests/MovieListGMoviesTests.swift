//
//  MovieListGMoviesTests.swift
//  GMoviesTests
//
//  Created by Gilang Ramdhani Putra on 08/05/22.
//

import XCTest
@testable import GMovies

class MovieListGMoviesTests: XCTestCase {

    var sut : APIService!
    
    override func setUp() {

        super.setUp()
        
      
        setupData()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func setupData() {
        sut = APIService()
    }
    
    func testPopularMovies() {
        setupData()
        let expected = XCTestExpectation(description: "Movie Popular does load popular and runs the callback closure")
        sut.getData(preferences: "Popular", page: 1, language: "en-US"){[weak self] (results) in
            XCTAssertNotNil(results)

            expected.fulfill()
            self?.wait(for: [expected], timeout: 10.0)
        }
        
    }
    
    func testTopRatedMovies() {
        setupData()
        let expected = XCTestExpectation(description: "Movie Top Rated does load popular and runs the callback closure")
        sut.getData(preferences: "top_rated", page: 1, language: "en-US"){[weak self] (results) in
            XCTAssertNotNil(results)

            expected.fulfill()
            self?.wait(for: [expected], timeout: 10.0)
        }
        
    }
    
    func testUpComingMovies() {
        setupData()
        let expected = XCTestExpectation(description: "Movie UpComing does load popular and runs the callback closure")
        sut.getData(preferences: "upcoming", page: 1, language: "en-US"){[weak self] (results) in
            XCTAssertNotNil(results)

            expected.fulfill()
            self?.wait(for: [expected], timeout: 10.0)
        }
        
    }
    
    func testNowPlayingMovies() {
        setupData()
        let expected = XCTestExpectation(description: "Movie Now Playing does load popular and runs the callback closure")
        sut.getData(preferences: "now_playing", page: 1, language: "en-US"){[weak self] (results) in
            XCTAssertNotNil(results)

            expected.fulfill()
            self?.wait(for: [expected], timeout: 10.0)
        }
        
    }

}
