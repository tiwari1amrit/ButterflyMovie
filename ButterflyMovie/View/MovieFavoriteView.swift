//
//  MovieFavoriteView.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

struct MovieFavoriteView: View {
    
    @ObservedObject var movieSearchVM = MovieSearchVM()
    @Binding var tabSelection: Int
    
    var body: some View {
        
        NavigationView {
            
            if let movies = movieSearchVM.movies, movies.count > 0{
                List{
                    ForEach(movies) { movie in
                        MovieView(movieDetail: movie, movieSearchVM: movieSearchVM, onlyFavorite: true)
                    }
                }
            }  else{
                VStack{
                    Text("Please mark the view for favorite")
                        .font(.title2)
                        .modifier(CenterModifier())
                    
                    Button(action: {
                        self.tabSelection = 0
                    }, label: {
                        Text(" Go to search page ")
                            .font(.title2)
                    })
                    .modifier(CenterModifier())
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.regular)
                    .tint(.red)
                }
            }
        }
        .onAppear{
            movieSearchVM.getMovieList(onlyFavorite: true)
        }
    }
}

#Preview {
    NavigationStack{
        MovieFavoriteView(tabSelection: .constant(1))
    }
}


struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
