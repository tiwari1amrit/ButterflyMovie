//
//  WebImageView.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI
import Kingfisher

struct WebImageView: View {
    let url: URL
        
    var body: some View {
        
        KFImage.url(url)
            .placeholder{
                Image("dummyCinema")
                    .resizable()
            }
            .resizable()
            .fade(duration: 0.9)
        
    }
}

#Preview {
    WebImageView(url: Urls.placeHolderImage())
}

