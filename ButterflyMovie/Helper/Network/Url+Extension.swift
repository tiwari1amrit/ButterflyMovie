//
//  Url.swift
//  Inks
//
//  Created by Amrit Tiwari on 9/1/2023.
//

import Foundation

public struct Urls {
    
    static let baseUrl: String = {
        return "https://api.themoviedb.org/3"
    }()
    
    static private let baseImageUrl: String = {
        return "https://image.tmdb.org/t/p/w500"
    }()
    
    // MARK: Movie
    static let apiKey = "955ce287e75605eac84af261618f20a6"
    
    static func searchMovie() -> URL{
        
        guard let url = URL(string: baseUrl + "/search/movie") else{
            fatalError("Invalid Url")
        }
        return url
    }
    
    static func imageUrl(_ path: String) -> String{
        
        return baseImageUrl + path
    }
    
    static func placeHolderImage() -> URL{
        guard let url = URL(string: "https://via.placeholder.com/250x250.jpg") else{
            fatalError("Invalid Url")
        }
        return url
    }
    
}
