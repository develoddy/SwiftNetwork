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

    @NSManaged public var cd13_updated_at: String?
    @NSManaged public var cd13_created_at: String?
    @NSManaged public var cd13_users_id  : Int64
    @NSManaged public var cd13_ref_id    : Int64
    @NSManaged public var cd13_type_id   : Int64
    @NSManaged public var cd13_id        : Int64
    //@NSManaged public var comments: CD0014_comments?

}

extension CD0013_likes : Identifiable {

}
