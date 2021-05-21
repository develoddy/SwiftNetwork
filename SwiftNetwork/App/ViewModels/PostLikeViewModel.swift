//
//  ProfileViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/5/21.
//

import Foundation

/*
struct IReqResponsePostLikeViewModel {
    var data: [PostLikeViewModel]?
    var status: String?
}

struct PostLikeViewModel {
    let username: String?
    var postIdentifier: String?
    let text: String?
    let likes: Int?
}
*/

// MARK: - PostLike
struct PostLikeViewModel {
    let username: String
    let postIdentifier: String
    let text: String
    let likes: Int
}
