//
//  PersistenceController.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 26/3/2024.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ButterflyMovie")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("Failed to save Core Data context: \(error)")
            }
        }
    }
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "ButterflyMovie")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        viewContext.automaticallyMergesChangesFromParent = true
    }
}
