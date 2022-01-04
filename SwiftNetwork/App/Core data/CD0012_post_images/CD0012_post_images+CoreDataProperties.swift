//
//  CD0012_post_images+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 30/12/21.
//
//

import Foundation
import CoreData


extension CD0012_post_images {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD0012_post_images> {
        return NSFetchRequest<CD0012_post_images>(entityName: "CD0012_post_images")
    }

    @NSManaged public var cd12_post_id      : Int64
    @NSManaged public var cd12_image_id     : Int64
    @NSManaged public var cd12_created_at   : String?
    @NSManaged public var cd12_updated_at   : String?
    //@NSManaged public var post              : CD0011_posts?
    @NSManaged public var cd12_image        : CD0010_images?

}

// MARK: Add Image.
extension CD0012_post_images {
    @objc(addCd12_imageObject:)
    @NSManaged public func addToCd12_image(_ value: CD0010_images)

    @objc(removeCd12_imageObject:)
    @NSManaged public func removeFromCd12_image(_ value: CD0010_images)
}

extension CD0012_post_images : Identifiable { }
