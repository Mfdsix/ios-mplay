//
//  CoreDataManager.swift
//  MPlay
//
//  Created by maputh on 24/02/25.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "WatchlistModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load Core Data: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func addToWatchlist(id: Int, title: String, image: String?, releaseDate: String?, rating: Double?) {
        let watchlistItem = Watchlist(context: context)
        watchlistItem.id = Int64(id)
        watchlistItem.title = title
        watchlistItem.image = image
        watchlistItem.releaseDate = releaseDate
        watchlistItem.rating = rating ?? 0

        saveContext()
    }

    func getWatchlist() -> [Watchlist] {
        let fetchRequest: NSFetchRequest<Watchlist> = Watchlist.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch watchlist: \(error)")
            return []
        }
    }

    func removeFromWatchlist(id: Int) {
        let fetchRequest: NSFetchRequest<Watchlist> = Watchlist.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                context.delete(item)
            }
            saveContext()
        } catch {
            print("Failed to delete item: \(error)")
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save Core Data: \(error)")
        }
    }
}

