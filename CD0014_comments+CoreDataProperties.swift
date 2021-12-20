//
//  CD0014_comments+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/12/21.
//
//

import Foundation
import CoreData

extension CD0014_comments {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD0014_comments> {
        return NSFetchRequest<CD0014_comments>(entityName: "CD0014_comments")
    }

    @NSManaged public var cd14_updated_at: String?
    @NSManaged public var cd14_created_at: String?
    @NSManaged public var cd14_comentario_id: Int64
    @NSManaged public var cd14_users_id: Int64
    @NSManaged public var cd14_content: String?
    @NSManaged public var cd14_ref_id: Int64
    @NSManaged public var cd14_type_id: Int64
    @NSManaged public var cd14_id: Int64
    @NSManaged public var cd14_user: CD0001_users?
    ///@NSManaged public var post: CD0011_posts?

}

// MARK: Add User.
extension CD0014_comments {

    @objc(addCd14_userObject:)
    @NSManaged public func addToCd14_user(_ value: CD0001_users)

    @objc(removeCd14_userObject:)
    @NSManaged public func removeFromCd14_user(_ value: CD0001_users)

    @objc(addCd14_user:)
    @NSManaged public func addToCd14_user(_ values: NSSet)

    @objc(removeCd14_user:)
    @NSManaged public func removeFromCd14_user(_ values: NSSet)

}



extension CD0014_comments : Identifiable {}
