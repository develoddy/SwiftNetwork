//
//  CD0013_likes+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 20/12/21.
//
//

import Foundation
import CoreData


extension CD0013_likes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD0013_likes> {
        return NSFetchRequest<CD0013_likes>(entityName: "CD0013_likes")
    }

    @NSManaged public var updated_at: String?
    @NSManaged public var created_at: String?
    @NSManaged public var users_id: Int64
    @NSManaged public var ref_id: Int64
    @NSManaged public var type_id: Int64
    @NSManaged public var id: Int64
    @NSManaged public var comments: CD0014_comments?

}

extension CD0013_likes : Identifiable {

}
