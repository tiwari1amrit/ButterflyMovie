//
//  MovieDataManager.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 26/3/2024.
//

import Foundation
import CoreData

struct MovieDataManager{
    
    static func deletePreviousAndSaveData(_ movies : [MovieDetail]){
        self.deleteMovie {
            saveMoviesToCoreData(movies)
        }
    }
    
    //MARK: Save in core data for offline use
    static private func saveMoviesToCoreData(_ movies : [MovieDetail]) {
        
        let context = PersistenceController.shared.viewContext
        
        for movie in movies {
            let movieEntity = MovieDetailDB(context: context)
            movieEntity.id = Int32(movie.id)
            movieEntity.title = movie.title
            movieEntity.overview = movie.overview
            movieEntity.voteCount = Int32(movie.voteCount ?? 0)
            movieEntity.popularity = movie.popularity ?? 0
            movieEntity.releaseDate = movie.releaseDate
            movieEntity.backdropPath = movie.backdropPath
            movieEntity.posterPath = movie.posterPath
            
            do {
                try context.save()
            } catch {
                print("Failed to save movie to Core Data: \(error)")
            }
        }
    }
    
    static func deleteMovie(completion: ()->()?) {
        let viewContext = PersistenceController.shared.viewContext
        
        let fetchRequest: NSFetchRequest<MovieDetailDB> = MovieDetailDB.fetchRequest()
        do {
            let movies = try viewContext.fetch(fetchRequest)
            for movie in movies {
                viewContext.delete(movie)
            }
            
            try! viewContext.save()
            completion()
        }catch{
            print("Error fetching movies from Core Data: \(error)")
        }
    }
    
    static func fetchMoviesFromCoreData() -> [MovieDetail]?{
        let viewContext = PersistenceController.shared.viewContext
        
        let fetchRequest: NSFetchRequest<MovieDetailDB> = MovieDetailDB.fetchRequest()
        
        do {
            let movieEntities = try viewContext.fetch(fetchRequest)
            
            // Map MovieDetailEntity objects to MovieDetail model objects
            let mappedMovies = movieEntities.map { movieEntity -> MovieDetail in
                return MovieDetail(
                    id: Int(movieEntity.id),
                    title: movieEntity.title ?? "",
                    overview: movieEntity.overview ?? "",
                    voteCount : Int(movieEntity.voteCount),
                    popularity : movieEntity.popularity,
                    releaseDate : movieEntity.releaseDate,
                    backdropPath : movieEntity.backdropPath,
                    posterPath : movieEntity.posterPath
                )
            }
            return mappedMovies
        } catch {
            print("Error fetching movies from Core Data: \(error)")
        }
        return nil
    }
}
