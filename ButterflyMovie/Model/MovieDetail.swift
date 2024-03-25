//
//  MovieDetail.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import Foundation

struct Movie: Codable {
    
    let results: [MovieDetail]
}


struct MovieDetail: Codable, Identifiable {
    static func == (lhs: MovieDetail, rhs: MovieDetail) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    var overview: String
    var voteCount: Int?
    var popularity: Double?
    
    private var releaseDate: String?
    private var backdropPath: String?
    private var posterPath: String?
    
    init(id: Int, title: String, overview: String, voteCount: Int? = nil, popularity: Double? = nil, releaseDate: String? = nil, backdropPath: String? = nil, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.overview = overview
        self.voteCount = voteCount
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
        self.posterPath = posterPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, popularity, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteCount = "vote_count"
    }
    
    var backdropURL: URL? {
        return URL(string: Urls.imageUrl(backdropPath ?? ""))
    }
    
    var posterURL: URL? {
        
        return URL(string: Urls.imageUrl(posterPath ?? ""))
    }
    
    var releaseDateReadbale : String? {
        convertToDate(releaseDate ?? "")
    }
    
    func convertToDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateStyle = .long
            return outputDateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
}


