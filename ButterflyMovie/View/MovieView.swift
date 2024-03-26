//
//  MovieView.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

struct MovieView: View {
    let movieDetail: MovieDetail
    let movieSearchVM: MovieSearchVM
    let onlyFavorite: Bool

    var body: some View {
        NavigationLink(destination: MovieDetailView(movieDetail: movieDetail)) {
            HStack(alignment: .top){
                WebImageView(
                    url: movieDetail.posterURL ?? Urls.placeHolderImage())
                .frame(width: 100)
                .aspectRatio(1/1.1, contentMode: .fit)
                .cornerRadius(8)
                .shadow(radius: 4)
                
                VStack(alignment: .leading, spacing: 0){
                    Text(movieDetail.title)
                        .font(.title2)
                        .padding(.bottom, 3)
                        .lineLimit(3)
                    Text(movieDetail.releaseDateReadbale ?? "")
                        .lineLimit(2)
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
                Spacer()
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    movieSearchVM.toggleFavorite(withId: movieDetail.id)
                    movieSearchVM.getMovieList(onlyFavorite: onlyFavorite)
                } label: {
                    if movieDetail.isFavorite {
                        Image(systemName: "star.fill")
                            .font(.title3)
                            .symbolVariant(.fill)
                            .foregroundColor(.yellow)
                    } else {
                        Image(systemName: "star")
                            .font(.title3)
                            .symbolVariant(.fill)
                            .foregroundColor(.gray.opacity(0.4))
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .frame(width: 50,height: 50)
            }
        }
    }
}


#Preview {
    MovieView(
        movieDetail: MovieDetail(
            id: 10, title: "hello ewewe ewewe ",
            overview: "", isFavorite: false),
        movieSearchVM: .init(), onlyFavorite: false)
}
