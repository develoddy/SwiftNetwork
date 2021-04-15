//
//  Models.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 15/4/21.
//

import Foundation

enum Gender {
    case male, female, ether
}

struct User {
    let name: (first:String, last:String)
    let username: String
    let bio: String
    let birthDate: Int
    let gender: Gender
    let email: String
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType {
    case photo, video
}

/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComments]
    let createDate: Date
    let taggedUsers: [User]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommenttLike {
    let username: String
    let commentIdentifier: String
}

struct PostComments {
    let identifier: String
    let username: String
    let text: String
    let createDate: String
    let likes: [CommenttLike]
}
