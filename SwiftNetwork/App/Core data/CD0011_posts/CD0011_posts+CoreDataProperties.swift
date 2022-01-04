//
//  CD0011_posts+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 4/1/22.
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
    
    @NSManaged public var comments          : CD0014_comments?      ///To-Many
    @NSManaged public var likes             : CD0013_likes?         ///To-Many
    @NSManaged public var taggeds           : CD0023_taggeds?       ///To-Many
    @NSManaged public var userAuthor        : CD0001_users?         ///To-One
    @NSManaged public var postImage         : CD0012_post_images?   ///To-Many
    /*@NSManaged public var comments: NSSet?
    @NSManaged public var likes: NSSet?
    @NSManaged public var postImage: NSSet?
    @NSManaged public var taggeds: NSSet?
    @NSManaged public var userAuthor: CD0001_users?*/

}

// MARK: Generated accessors for comments
extension CD0011_posts {
    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: CD0014_comments)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: CD0014_comments)
}

// MARK: Generated accessors for likes
extension CD0011_posts {
    @objc(addLikesObject:)
    @NSManaged public func addToLikes(_ value: CD0013_likes)

    @objc(removeLikesObject:)
    @NSManaged public func removeFromLikes(_ value: CD0013_likes)
}

// MARK: Generated accessors for postImage
extension CD0011_posts {
    @objc(addPostImageObject:)
    @NSManaged public func addToPostImage(_ value: CD0012_post_images)

    @objc(removePostImageObject:)
    @NSManaged public func removeFromPostImage(_ value: CD0012_post_images)
}

// MARK: Generated accessors for taggeds
extension CD0011_posts {
    @objc(addTaggedsObject:)
    @NSManaged public func addToTaggeds(_ value: CD0023_taggeds)

    @objc(removeTaggedsObject:)
    @NSManaged public func removeFromTaggeds(_ value: CD0023_taggeds)
}

extension CD0011_posts : Identifiable {

}
