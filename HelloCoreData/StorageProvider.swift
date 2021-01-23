//
//  StorageProvider.swift
//  HelloCoreData
//
//  Created by Ian Manor on 22/01/21.
//

import CoreData

class StorageProvider {
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "Model")

        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider {
    func saveMovie(named name: String) {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.name = name

        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save movie: \(error)")
        }
    }

    func deleteMovie(_ movie: Movie) {
        persistentContainer.viewContext.delete(movie)

        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
    }

    func updateMovies() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
    }

    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch movies: \(error)")
            return []
        }
    }
}
