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
    
    //MARK: Fetch
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
    
    //func fetchUserPost(email: String) {
    func fetchUserPost <T: NSManagedObject>(_ type: T.Type, author_ref_id: Int, email: String?) -> [T]  {
        // Fetching
        let fetchRequest = T.fetchRequest()
        // Create Predicate
        fetchRequest.predicate = NSPredicate(format: "author_ref_id == \(author_ref_id)")
        do {
            let result = try viewContext.fetch(fetchRequest)
            
            return result as! [T]
        } catch let error as NSError {
            print("Error al recuperar: \(error)")
            return []
        }
    }
    
    
//    func fetchPostImages <T: NSManagedObject>(_ type: T.Type, post_id: Int){
//        // Fetching
//        let fetchRequest = T.fetchRequest()
//        // Create Predicate
//        fetchRequest.predicate = NSPredicate(format: "post_id == \(post_id)")
//        do {
//            let result = try viewContext.fetch(fetchRequest)
//            print(result)
//            //return result as! [T]
//        } catch let error as NSError {
//            print("Error al recuperar: \(error)")
//            //return []
//        }
//    }
    
  
    //MARK: Delete All Records
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
