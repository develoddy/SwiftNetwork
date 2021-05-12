//
//  WebUserSearch.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 12/5/21.
//

import Foundation

struct WebUserSearchData: Codable {
    var user: [UserDecodable]
}

struct UserDecodable: Codable {
    var name: String?
}

//Model
struct WebUserModel {
    var user: [Search]
}

struct Search {
    var name: String?
}
