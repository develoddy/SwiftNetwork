//
//  DatabaseHandler.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 13/12/21.
//

import UIKit
import CoreData

class DatabaseHandler {
    
    private let viewContext : NSManagedObjectContext!
    
    static let shared = DatabaseHandler()
    
    init() {
        viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    //MARK: Add
    func add <T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        let object = T(entity: entity, insertInto: viewContext)
        return object
    }
    
    //MARK: fetch
    func fetch <T: NSManagedObject>(_ type: T.Type) -> [T]  {
        let request = T.fetchRequest()
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    //func deleteAllRecords() {
    func deleteAllRecords <T: NSManagedObject>(object: [T]) {
        guard let entityName = T.entity().name else { return }
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
            print("DeleteAllRecords")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: delete
    func delete <T: NSManagedObject>(object: T) {
        viewContext.delete(object)
        save() == true ? print("Delete.") : print("no delete.")
    }
    
    //MARK: save
    func save() -> Bool  {
        do {
            try viewContext.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
