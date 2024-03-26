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
                
                FavoriteButton(
                    movieDetail: movieDetail,
                    movieSearchVM: movieSearchVM,
                    onlyFavorite: onlyFavorite)
                .padding(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: -40))
            }
        }
    }
}

struct FavoriteButton: View{
    let movieDetail: MovieDetail
    let movieSearchVM: MovieSearchVM
    let onlyFavorite: Bool
    
    var body: some View{
        Button {
            movieSearchVM.toggleFavorite(withId: movieDetail.id)
            movieSearchVM.getMovieList(onlyFavorite: onlyFavorite)
        } label: {
            if movieDetail.isFavorite {
                Image(systemName: "star.fill")
                    .modifier(StarModifier(fillColor: .red))
            } else {
                Image(systemName: "star")
                    .modifier(
                        StarModifier(
                            fillColor: .gray.opacity(0.4)))
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .frame(width: 50,height: 50)
    }
}

struct StarModifier: ViewModifier {
    let fillColor : Color
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .symbolVariant(.fill)
            .foregroundColor(fillColor)
        
    }
}

#Preview {
    MovieView(
        movieDetail: MovieDetail(
            id: 10, title: "hello ewewe ewewe ",
            overview: "", isFavorite: false),
        movieSearchVM: .init(), onlyFavorite: false)
}
