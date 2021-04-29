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
    let profilePicture: URL
    let birthDate: Date
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

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url resolution photo
    let caption: String? //Subtitle
    let likeCount: [PostLike]
    //let comments: [PostComments]
    let comments: [PostComments]
    let createDate: Date
    let taggedUsers: [User]
    let owner: User
}

struct Descriptions {
    let text: String
    let likes: Int
}

struct PostLike {
    let username: String
    let postIdentifier: String
    let text: String
    let likes: Int
}


/*struct PostComments {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommenttLike]
}*/
class PostComments {
    var identifier: String
    var username: String
    var text: String
    var createDate: Date
    var likes: [CommenttLike]
    
    init(identifier: String, username:String, text:String, createDate:Date, likes:[CommenttLike]) {
        self.identifier = identifier
        self.username = username
        self.text = text
        self.createDate = createDate
        self.likes = likes
    }
}

struct CommenttLike {
    let username: String
    let commentIdentifier: String
}

struct CollectionTableCellModel {
    let title: String
    let imageName: String
}

