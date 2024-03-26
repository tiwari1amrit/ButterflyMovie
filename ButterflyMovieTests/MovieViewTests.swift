//
//  MovieViewTests.swift
//  ButterflyMovieTests
//
//  Created by Amrit Tiwari on 26/3/2024.
//

import XCTest
@testable import ButterflyMovie


final class MovieViewTests: XCTestCase {
    
    var movieView: MovieView!
    var movieSearchVM: MovieSearchVM!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        movieSearchVM = MovieSearchVM()
        
        movieView = MovieView(
            movieDetail: MovieDetail(
                id: 10, title: "Hello this is dhoom 3",
                overview: "Put teardown code here. This method is called after the invocation of each test method in the class.",
                isFavorite: false),
            movieSearchVM: MovieSearchVM(),
            onlyFavorite: false)
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        movieSearchVM = nil
        movieView = nil
    }
    
    func testViewComponents() {
        XCTAssertNotNil(movieView.body)
        XCTAssertNotNil(movieView.movieDetail)
        XCTAssertNotNil(movieView.movieSearchVM)
    }
    
    func testFavoriteButton(){
        let movieId = 799155
        let initialFavoriteStatus = movieView.movieDetail.isFavorite
        
        movieSearchVM.toggleFavorite(withId: movieId)
        movieSearchVM.fetchMovieSuccess = { movies in
            let movie = movies?.filter{ $0.isFavorite == initialFavoriteStatus}
            XCTAssertNotEqual(initialFavoriteStatus, movie?.first?.isFavorite)
            
        }
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
