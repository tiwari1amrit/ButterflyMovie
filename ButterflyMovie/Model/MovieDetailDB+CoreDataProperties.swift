//
//  MovieDetailDB+CoreDataProperties.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 26/3/2024.
//
//

import Foundation
import CoreData


extension MovieDetailDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetailDB> {
        return NSFetchRequest<MovieDetailDB>(entityName: "MovieDetailDB")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int32
    @NSManaged public var isFavorite: Bool
    @NSManaged public var overview: String?
    @NSManaged public var popularity: NSNumber?
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteCount: NSNumber?

}

extension MovieDetailDB : Identifiable {

}
