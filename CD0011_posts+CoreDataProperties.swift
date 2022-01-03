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

    @NSManaged public var author_ref_id     : Int64
    @NSManaged public var content           : String?
    @NSManaged public var created_at        : String?
    @NSManaged public var finish_at         : String?
    @NSManaged public var id                : Int64
    @NSManaged public var id_post_type      : Int64
    @NSManaged public var lat               : Int64
    @NSManaged public var lng               : Int64
    @NSManaged public var nivel_id          : Int64
    @NSManaged public var postt_type_id     : Int64
    @NSManaged public var receptor_ref_id   : Int64
    @NSManaged public var receptor_type_id  : Int64
    @NSManaged public var start_at          : String?
    @NSManaged public var title             : String?
    @NSManaged public var updated_at        : String?
    @NSManaged public var comments          : CD0014_comments?      ///To-Many
    @NSManaged public var likes             : CD0013_likes?         ///To-Many
    @NSManaged public var taggeds           : CD0023_taggeds?       ///To-Many
    @NSManaged public var userAuthor        : CD0001_users?         ///To-One
    @NSManaged public var postImage         : CD0012_post_images?   ///To-Many

}

// MARK: Generated accessors for comments
extension CD0011_posts {

    /// Add Comments. To-Many.
    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: CD0014_comments)
    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: CD0014_comments)
    
    /// Add Likes. To-Many.
    @objc(addLikesObject:)
    @NSManaged public func addToLikes(_ value: CD0013_likes)
    @objc(removeLikesObject:)
    @NSManaged public func removeFromLikes(_ value: CD0013_likes)
    
    /// Add Taggeds. To-Many.
    @objc(addTaggedsObject:)
    @NSManaged public func addToTaggeds(_ value: CD0023_taggeds)
    @objc(removeTaggedsObject:)
    @NSManaged public func removeFromTaggeds(_ value: CD0023_taggeds)
    
    /// Add UserAuthor. To-One.
    @objc(addUserAuthorObject:)
    @NSManaged public func addToUserAuthor(_ value: CD0001_users)
    @objc(removeUserAuthorObject:)
    @NSManaged public func removeFromUserAuthor(_ value: CD0001_users)
    
    /// Add Post Image. To-Many.
    @objc(addPostImageObject:)
    @NSManaged public func addToPostImage(_ value: CD0012_post_images)
    @objc(removePostImageObject:)
    @NSManaged public func removeFromPostImage(_ value: CD0012_post_images)
}



extension CD0011_posts : Identifiable {}
