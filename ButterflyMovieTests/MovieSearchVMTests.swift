//
//  MovieSearchVMTests.swift
//  ButterflyMovieTests
//
//  Created by Amrit Tiwari on 26/3/2024.
//

import XCTest
@testable import ButterflyMovie
import Combine

final class MovieSearchVMTests: XCTestCase {
    
    var movieSearchVM: MovieSearchVM!
    let networkManager: NetworkManager = NetworkManager.shared
    var movieDataManager: MovieDataManager!
    private var cancellable: AnyCancellable?
    
    private let query = "Atta"
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        
        self.movieSearchVM = MovieSearchVM()
        movieDataManager = MovieDataManager()
        
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        movieSearchVM = nil
        movieDataManager = nil
    }
    
    func testSearch(){
        movieSearchVM.search(query: query)
        
        movieSearchVM.fetchMovieSuccess = { movies in
            XCTAssertNotNil(movies)
        }
        XCTAssertTrue(movieSearchVM.isLoading)
        XCTAssertNil(movieSearchVM.error)
        
    }
    
    func testGetMovieList() {
        let favorite = false
        
        movieSearchVM.getMovieList(onlyFavorite: favorite)
        XCTAssertNotNil(movieSearchVM.movies)
    }
    
    func testToggleFavorite() {
        let movieId = 624091
        
        movieSearchVM.toggleFavorite(withId: movieId)
        
        movieSearchVM.fetchMovieSuccess = { movies in
            let movieDB = self.movieDataManager.fetchMovieFromCoreData(withID: movieId)
            
            XCTAssertNotNil(movieDB)
            
            if let movieDB = movieDB {
                let movies = movies?.filter{ $0.id == movieId }
                XCTAssertEqual(movieDB.isFavorite, movies?.first?.isFavorite)
            }
        }
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
