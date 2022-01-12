//
//  CD0008_profiles+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 29/12/21.
//
//

import Foundation
import CoreData

extension CD0008_profiles {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD0008_profiles> {
        return NSFetchRequest<CD0008_profiles>(entityName: "CD0008_profiles")
    }

    @NSManaged public var cd08_address          : String?
    @NSManaged public var cd08_bio              : String?
    @NSManaged public var cd08_country_id       : Int64
    @NSManaged public var cd08_created_at       : String?
    @NSManaged public var cd08_data             : String?
    @NSManaged public var cd08_day_of_birth     : String?
    @NSManaged public var cd08_dislikes         : String?
    @NSManaged public var cd08_gender           : String?
    @NSManaged public var cd08_id               : Int64
    @NSManaged public var cd08_image            : String?
    @NSManaged public var cd08_image_header     : String?
    @NSManaged public var cd08_likes            : String?
    @NSManaged public var cd08_nivel_id         : Int64
    @NSManaged public var cd08_phone            : String?
    @NSManaged public var cd08_public_email     : String?
    @NSManaged public var cd08_sentimental_id   : Int64
    @NSManaged public var cd08_title            : String?
    @NSManaged public var cd08_updated_at       : String?
    @NSManaged public var cd08_users_id         : Int64
    @NSManaged public var cd08_valor            : String?
    @NSManaged public var user                  : CD0001_users?
}

extension CD0008_profiles : Identifiable {
}
