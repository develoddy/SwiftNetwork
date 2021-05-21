//
//  UserPostViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation

// MARK: - UserPost
public struct UserPostViewModel {
    let identifier: String
    let postType: UserPostTypeViewModel
    let thumbnailImage: URL
    let postURL: URL // either video url resolution photo
    let caption: String? //Subtitle
    let likeCount: [PostLikeViewModel]
    let comments: [PostCommentsViewModel]
    let createDate: Date
    let taggedUsers: [UserViewModel]
    let owner: UserViewModel
}

// MARK: - UserPostType
public enum UserPostTypeViewModel: String {
    case photo = "Photo"
    case video = "Video"
}
