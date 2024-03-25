//
//  ContentView.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchVM = MovieSearchVM()
            
    var body: some View {
        NavigationStack {
            List {
                
                SearchBarView(placeholder: Constant.Message.searchMovie, text: self.$movieSearchVM.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                ActivityIndicatorContainer(isLoading: movieSearchVM.isLoading, error: movieSearchVM.error) {
                    self.movieSearchVM.search(query: self.movieSearchVM.query)
                }

                if let movies = movieSearchVM.movies{
                    ForEach(movies) { movie in
                        MovieView(movieDetail: movie)
                    }
                }                
            }
            .onAppear{
                movieSearchVM.startObserve()
            }
            .navigationTitle("Search Movies")
        }
    }
}


#Preview {
    MovieSearchView()
}
