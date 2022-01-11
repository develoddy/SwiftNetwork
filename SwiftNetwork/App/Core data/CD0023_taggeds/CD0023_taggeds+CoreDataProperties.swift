//
//  CD0023_taggeds+CoreDataProperties.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/12/21.
//
//

import Foundation
import CoreData


extension CD0023_taggeds {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CD0023_taggeds> {
        return NSFetchRequest<CD0023_taggeds>(entityName: "CD0023_taggeds")
    }

    @NSManaged public var cd23_updated_at        : String?
    @NSManaged public var cd23_created_at        : String?
    @NSManaged public var cd23_id_count          : Int64
    @NSManaged public var cd23_id_gender         : Int64
    @NSManaged public var cd23_id_post           : Int64
    @NSManaged public var cd23_valor             : String?
    @NSManaged public var cd23_imagen_bin        : String?
    @NSManaged public var cd23_sentimental_id    : Int64
    @NSManaged public var cd23_nivel_id          : Int64
    @NSManaged public var cd23_users_id          : Int64
    @NSManaged public var cd23_phone             : String?
    @NSManaged public var cd23_address           : String?
    @NSManaged public var cd23_dislikes          : String?
    @NSManaged public var cd23_likes             : String?
    @NSManaged public var cd23_title             : String?
    @NSManaged public var cd23_image_header      : String?
    @NSManaged public var cd23_image             : String?
    @NSManaged public var cd23_country_id        : Int64
    @NSManaged public var cd23_join_date         : String?
    @NSManaged public var cd23_public_email      : String?
    @NSManaged public var cd23_day_of_birth      : String?
    @NSManaged public var cd23_profile_picture   : String?
    @NSManaged public var cd23_bio               : String?
    @NSManaged public var cd23_username          : String?
    @NSManaged public var cd23_last              : String?
    @NSManaged public var cd23_name              : String?
    @NSManaged public var cd23_id                : Int64

}

extension CD0023_taggeds : Identifiable {

}
