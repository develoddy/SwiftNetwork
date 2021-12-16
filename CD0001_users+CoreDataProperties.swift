//
//  CD0001_users+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 13/12/21.
//
//

import Foundation
import CoreData


extension CD0001_users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD0001_users> {
        return NSFetchRequest<CD0001_users>(entityName: "CD0001_users")
    }

    @NSManaged public var cd01_updated_at: String?
    @NSManaged public var cd01_remember_token: String?
    @NSManaged public var cd01_created_at: String?
    @NSManaged public var cd01_id_count: Int64
    @NSManaged public var cd01_password: String?
    @NSManaged public var cd01_email_verified_at: String?
    @NSManaged public var cd01_email: String?
    @NSManaged public var cd01_username: String?
    @NSManaged public var cd01_name: String?
    @NSManaged public var cd01_id: Int64

}

