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
        Text("Hello World")
        .navigationBarTitle(movieDetail.title)
    }
}

#Preview {
    MovieDetailView(movieDetail: MovieDetail(id: 1, title: "Hello", overview: ""))
}

