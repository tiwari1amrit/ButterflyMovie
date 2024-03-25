//
//  MovieDetailDB+CoreDataProperties.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//
//

import Foundation
import CoreData


extension MovieDetailDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDetailDB> {
        return NSFetchRequest<MovieDetailDB>(entityName: "MovieDetailDB")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var voteCount: Int32
    @NSManaged public var popularity: Double
    @NSManaged public var releaseDate: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var isFavorite: Bool

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(false, forKey: "isFavorite")
    }
}

extension MovieDetailDB : Identifiable {

}
