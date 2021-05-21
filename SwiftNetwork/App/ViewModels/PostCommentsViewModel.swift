//
//  PostCommentsViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation


// MARK: - PostComments
struct PostCommentsViewModel {
    var id: Int
    var username: String
    var type_id: Int
    var ref_id: Int
    var userss_id: Int
    var content: String
    var comentario_id: Int
    var createdAt: Date
    var likes: [CommenttLikeViewModel]
}

