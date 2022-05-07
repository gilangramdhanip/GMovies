//
//  PersistanceManager.swift
//  GMovies
//
//  Created by Gilang Ramdhani Putra on 07/05/22.
//

import CoreData

class PersitanceManager {
    
    static let shared = PersitanceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "GMovies")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func favoriteMovies(movie : Movie,  isFavorite: Bool) {
        
        print(" movies \(movie)")
        do {
            let movies = Movies(context: persistentContainer.viewContext)
            movies.id = Int64(movie.id)
            movies.title = movie.title
            movies.posterPath = movie.posterPath
            movies.overview = movie.overview
            movies.releaseDate = movie.releaseDate
            movies.voteAverage = movie.voteAverage
            movies.voteCount = Int64(movie.voteCount)
            movies.isFavorite = isFavorite
            
            saveContext()
        }
        
    }
    
    func unFavoriteMovies(movies : Movies) {
        persistentContainer.viewContext.delete(movies)
        saveContext()
    }
    
    func fetchFavoriteMovie() -> [Movies] {
        let  request : NSFetchRequest<Movies> = Movies.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "rating", ascending: true)]
        
        var movies : [Movies] = []
        
        do {
            movies = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching data")
        }
        
        return movies
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
