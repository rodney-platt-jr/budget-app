//
//  CoreDataManager.swift
//  FinalBudgetAppRCP
//
//  Created by Rodney Platt on 1/6/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private var persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to initialize Core Data stack \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
}
