//
//  MovieView.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

struct MovieView: View {
    let movieDetail: MovieDetail
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
                        .font(.system(size: 13))
                        .padding(.bottom, 3)
                        .lineLimit(3)
                    Text(movieDetail.releaseDateReadbale ?? "")
                        .lineLimit(2)
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0))
                Spacer()
            }
            
        }
    }
}


#Preview {
    MovieView(movieDetail: MovieDetail(id: 10, title: "hello ewewe ewewe ", overview: ""))
}