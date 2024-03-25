//
//  MovieSearchState.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class MovieSearchVM: ObservableObject {
    
    @Published var query = ""
    @Published var movies: [MovieDetail]?
    @Published var isLoading = false
    @Published var error: String?
    
    private var subscriptionToken: AnyCancellable?
    private let networkManager = NetworkManager.shared
    
    func startObserve() {
        guard subscriptionToken == nil else { return }
        
        self.subscriptionToken = self.$query
            .map { [weak self] text in
                guard let `self` = self else { return text }
                self.movies = MovieDataManager.fetchMoviesFromCoreData()
                self.error = nil
                return text
                
            }.throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
            .sink(receiveValue: { [weak self]  in
                guard let `self` = self else { return }
                self.search(query: $0)
            })
    }
    
    func search(query: String){
        self.error = nil
        self.isLoading = false
        
        guard !query.isEmpty else {
            return
        }
        self.isLoading = true
        
        let params = [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ]
        
        networkManager.fetchData(Urls.searchMovie(), withParameter: params) { [weak self] (response: Movie) in
            guard let `self` = self else { return }
            self.isLoading = false
            self.movies = nil
            self.movies = response.results
            MovieDataManager.deletePreviousAndSaveData(response.results)
            
        } withCompletionWithError: {[weak self] error in
            guard let `self` = self else { return }
            self.isLoading = false
            self.error = error
            self.movies = nil
            print(error)
        }
    }
    

    
    deinit {
        self.subscriptionToken?.cancel()
        self.subscriptionToken = nil
    }
}

