//
//  MovieDetailGMoviesTests.swift
//  GMoviesTests
//
//  Created by Gilang Ramdhani Putra on 08/05/22.
//

import XCTest
@testable import GMovies

class MovieDetailGMoviesTests: XCTestCase {
    
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
    
    func testMovieDetail() {
        setupData()
        let expected = XCTestExpectation(description: "APIService load movie detail and runs the callback closure")
        sut.getDetailData(idMovie: 763285, language: "eng-US" ) { (movieDetail) in
            XCTAssertNotNil(movieDetail)
            expected.fulfill()
            self.wait(for: [expected], timeout: 10.0)
        }

    }

}
