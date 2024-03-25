//
//  MovieDetailView.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

struct MovieDetailView: View {
    let movieDetail: MovieDetail
    
    var body: some View {
        ZStack{
            Rectangle().fill(Color(.red).opacity(0.2))
                .ignoresSafeArea()
            List{
                PosterView(
                    posterURL: movieDetail.backdropURL ?? movieDetail.posterURL)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                Text("Vote Count: \(movieDetail.voteCount ?? 0)")
                Text("Release Date: \(movieDetail.releaseDateReadbale ?? "")")
                
                Text(movieDetail.overview)
                    .font(.system(size: 14))
            }
            .cornerRadius(50)
            .padding(10)
        }
        .navigationBarTitle(movieDetail.title)
    }
}




#Preview {
    MovieDetailView(movieDetail: MovieDetail(id: 1, title: "Hello", overview: ""))
}

struct PosterView: View {
    let posterURL: URL?
    
    var body: some View {
        WebImageView(
            url: posterURL ?? Urls.placeHolderImage())
        .cornerRadius(8)
        .shadow(radius: 4)
        .aspectRatio(16/9, contentMode: .fit)
        .clipped()
    }
}

#Preview {
    PosterView(
        posterURL: URL(string:Urls.imageUrl("/bckxSN9ueOgm0gJpVJmPQrecWul.jpg")))
}

