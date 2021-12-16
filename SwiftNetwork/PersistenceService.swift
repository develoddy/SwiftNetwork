//
//  PersistenceService.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 11/12/21.
//
//
//import Foundation
//import CoreData
//
//class PersistenceService {
//    
//    private init() {}
//    static let shared = PersistenceService()
//    var managedContext: NSManagedObjectContext { return persistentContainer.viewContext }
//    
//    
//    //MARK: Initialize a Persistent Container
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "CoreData")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Unable to load persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
//    
//    
//    //MARK: Save Context
//    func saveContext() {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//}
