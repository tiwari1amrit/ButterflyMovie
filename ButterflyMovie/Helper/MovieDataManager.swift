//
//  MovieDataManager.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 26/3/2024.
//

import Foundation
import CoreData

struct MovieDataManager {
    
    func deletePreviousAndSaveData(_ movies: [MovieDetail]) {
        // check the favorite movies first
        self.deleteNonFavoriteMovies {
            saveMoviesToCoreData(movies)
        }
    }
    
    // MARK: Save in core data for offline use
    private func saveMoviesToCoreData(_ movies: [MovieDetail]) {
        for movie in movies {
            saveMovieDetail(movie)
        }
    }
    
    private func saveMovieDetail(_ movie: MovieDetail) {
        let viewContext = PersistenceController.shared.viewContext
        
        if let existingMovie = fetchMovieFromCoreData(withID: movie.id) {
            // Update the value if it exists
            existingMovie.isFavorite = true
        } else {
            // if not exist in the database, save it as a new movie
            let movieEntity = MovieDetailDB(context: viewContext)
            configureMovieEntity(movieEntity, with: movie)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save movie to Core Data: \(error)")
        }
    }
    
    //MARK: Toggle favorite status
    func toggleFavoriteStatus(for movieID: Int) {
        let viewContext = PersistenceController.shared.viewContext
        
        if let movie = fetchMovieFromCoreData(withID: movieID) {
            movie.isFavorite.toggle()
            do {
                try viewContext.save()
            } catch {
                print("Failed to toggle favorite status for movie \(movieID): \(error)")
            }
        }
    }
    
    func deleteNonFavoriteMovies(completion: @escaping () -> Void) {
        let viewContext = PersistenceController.shared.viewContext
        
        let fetchRequest: NSFetchRequest<MovieDetailDB> = MovieDetailDB.fetchRequest()
        do {
            let movies = try viewContext.fetch(fetchRequest)
            for movie in movies {
                if !movie.isFavorite {
                    viewContext.delete(movie)
                }
            }
            
            try! viewContext.save()
            completion()
        } catch {
            print("Error fetching movies from Core Data: \(error)")
        }
    }
    
    func fetchMovieFromCoreData(withID id: Int) -> MovieDetailDB? {
        let viewContext = PersistenceController.shared.viewContext
        
        let fetchRequest: NSFetchRequest<MovieDetailDB> = MovieDetailDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let movies = try viewContext.fetch(fetchRequest)
            return movies.first
        } catch {
            print("Error fetching movie from Core Data: \(error)")
            return nil
        }
    }
    
    func fetchMoviesFromCoreData(withFavorite favorite : Bool) -> [MovieDetail]? {
        
        let viewContext = PersistenceController.shared.viewContext
        
        let fetchRequest: NSFetchRequest<MovieDetailDB> = MovieDetailDB.fetchRequest()
        
        if favorite{
            fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
        }
        
        do {
            let movieEntities = try viewContext.fetch(fetchRequest)
            
            // Map MovieDetailEntity objects to MovieDetail model objects
            let mappedMovies = movieEntities.map { movieEntity -> MovieDetail in
                return MovieDetail(
                    id: Int(movieEntity.id),
                    title: movieEntity.title ?? "",
                    overview: movieEntity.overview ?? "",
                    isFavorite: movieEntity.isFavorite,
                    voteCount : movieEntity.voteCount as? Int,
                    popularity : movieEntity.popularity as? Double,
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
    
    
    private func configureMovieEntity(_ movieEntity: MovieDetailDB, with movie: MovieDetail) {
        movieEntity.id = Int32(movie.id)
        movieEntity.title = movie.title
        movieEntity.overview = movie.overview
        movieEntity.isFavorite = movie.isFavorite
        movieEntity.voteCount = movie.voteCount as NSNumber?
        movieEntity.popularity = movie.popularity as NSNumber?
        movieEntity.releaseDate = movie.releaseDate
        movieEntity.backdropPath = movie.backdropPath
        movieEntity.posterPath = movie.posterPath
    }
}
