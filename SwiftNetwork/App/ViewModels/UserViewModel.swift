//
//  UserViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation

// MARK: - User
struct UserViewModel {
    let name: (first:String, last:String)
    let username: String
    let bio: String
    let profilePicture: URL
    let dayOfBirth: Date
    let gender: GenderViewModel
    let publicEmail: String
    let counts: UserCountViewModel
    let joinDate: Date
    let countryId: Int
    let image: String
    let imageHeader: String
    let title: String
    let likes: String
    let dislikes: String
    let address: String
    let phone: String
    let userssId: Int
    let nivelId: Int
    let sentimentalId: Int
    let imagenBin: String
    let valor : String
    let id: Int
}


// MARK: - Gender
enum GenderViewModel {
    case male, female, ether
}
