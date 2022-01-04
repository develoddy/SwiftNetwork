//
//  CD0010_images+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 30/12/21.
//
//

import Foundation
import CoreData


extension CD0010_images {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD0010_images> {
        return NSFetchRequest<CD0010_images>(entityName: "CD0010_images")
    }

    @NSManaged public var cd10_id           : Int64
    @NSManaged public var cd10_src          : String?
    @NSManaged public var cd10_title        : String?
    @NSManaged public var cd10_content      : String?
    @NSManaged public var cd10_image_bin    : String?
    @NSManaged public var cd10_album_id     : Int64
    @NSManaged public var cd10_users_id     : Int64
    @NSManaged public var cd10_nivel_id     : Int64
    @NSManaged public var cd10_created_at   : String?
    @NSManaged public var cd10_updated_at   : String?
    //@NSManaged public var postImages        : CD0012_post_images?

}

extension CD0010_images : Identifiable {

}
