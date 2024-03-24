//
//  InMemoryCoreDataManager.swift
//  MyToDosTests
//
//  Created by Julia Gurbanova on 24.03.2024.
//

import Foundation
import CoreData
@testable import MyToDos

class InMemoryCoreDataManager: CoreDataManager {
    override init() {
        super.init()

        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType

        let container = NSPersistentContainer(name: "ToDoList")
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        persistentContainer = container
    }
}
