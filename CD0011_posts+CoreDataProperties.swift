//
//  CD0011_posts+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/12/21.
//
//

import Foundation
import CoreData


extension CD0011_posts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD0011_posts> {
        return NSFetchRequest<CD0011_posts>(entityName: "CD0011_posts")
    }

    @NSManaged public var author_ref_id: Int64
    @NSManaged public var content: String?
    @NSManaged public var created_at: String?
    @NSManaged public var finish_at: String?
    @NSManaged public var id: Int64
    @NSManaged public var id_post_type: Int64
    @NSManaged public var lat: Int64
    @NSManaged public var lng: Int64
    @NSManaged public var nivel_id: Int64
    @NSManaged public var postt_type_id: Int64
    @NSManaged public var receptor_ref_id: Int64
    @NSManaged public var receptor_type_id: Int64
    @NSManaged public var start_at: String?
    @NSManaged public var title: String?
    @NSManaged public var updated_at: String?
    @NSManaged public var comments: CD0014_comments?
    @NSManaged public var likes: CD0013_likes?
    //@NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension CD0011_posts {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: CD0014_comments)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: CD0014_comments)
    
    @objc(addLikesObject:)
    @NSManaged public func addToLikes(_ value: CD0013_likes)

    @objc(removeLikesObject:)
    @NSManaged public func removeFromLikes(_ value: CD0013_likes)
}



extension CD0011_posts : Identifiable {}
