//
//  ButterflyEnvironment.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 26/3/2024.
//

import Foundation

enum ButterflyEnvironment {
    
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist not found")
        }
        return dict
    }()
    
    static let apiKey: String = {
        guard let key = ButterflyEnvironment.infoDict["API_KEY"] as? String else {
            fatalError("API_KEY not found")
        }
        return key
    }()
    
    static let baseUrl: String = {
        guard let urlString = ButterflyEnvironment.infoDict["BASE_URL"] as? String else {
            fatalError("BASE_URL not found")
        }
        let correctedURLString = urlString.replacingOccurrences(
            of: "\\", with: "/")
        return correctedURLString
    }()
    
    static let baseImageUrl: String = {
        guard let urlString = ButterflyEnvironment.infoDict["IMAGE_BASE_URL"] as? String else {
            fatalError("IMAGE_BASE_URL not found")
        }
        let correctedURLString = urlString.replacingOccurrences(
            of: "\\", with: "/")
        return correctedURLString
    }()

}
