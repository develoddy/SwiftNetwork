//
//  CD0025_post_types+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 13/12/21.
//
//

import Foundation
import CoreData


extension CD0025_post_types {
    @NSManaged public var updated_at: String?
    @NSManaged public var created_at: String?
    @NSManaged public var video: String?
    @NSManaged public var photo: String?
    @NSManaged public var id: Int64

}


