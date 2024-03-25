//
//  MovieFavoriteView.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

struct MovieFavoriteView: View {
    
    @ObservedObject var movieSearchState = MovieSearchVM()
    @Binding var tabSelection: Int
    
    var body: some View {
        
        if let movies = movieSearchState.movies{
            ForEach(movies) { movie in
                MovieView(movieDetail: movie)
            }
        }  else{
            VStack{
                Text("Please mark the view for favorite")
                    .font(.title2)
                    .padding()
                Button(action: {
                    self.tabSelection = 0
                }, label: {
                    Text("Go to search page")
                        .font(.title2)
                })
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.regular)
                .tint(.red)
            }
        }
    }
}

#Preview {
    MovieFavoriteView(tabSelection: .constant(1))
}
