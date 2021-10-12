//
//  Models.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 15/4/21.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userPost = try? newJSONDecoder().decode(UserPost.self, from: jsonData)
///https://www.swiftbysundell.com/articles/model-controllers-in-swift/

import Foundation

struct UserPost {
    let userpost: [UserPostViewModel]
    let status: String
}


public struct UserPostViewModel {
    let identifier: String
    let postType: UserPostTypeViewModel
    let thumbnailImage: URL
    let postURL: URL
    let caption: String?
    let likeCount: [PostLikeViewModel]
    let comments: [PostCommentsViewModel]
    let createDate: Date
    let taggedUsers: [UserViewModel]
    let owner: UserViewModel
}

public enum UserPostTypeViewModel: String {
    case photo = "Photo"
    case video = "Video"
}

struct UserViewModel {
    ///var name: (first:String, last:String)?
    var name, last: String?
    var username: String?
    var bio: String?
    var profilePicture: URL?
    var dayOfBirth: Date?
    var gender: GenderViewModel?
    var publicEmail: String?
    var counts: UserCountViewModel?
    var joinDate: Date?
    var countryId: Int?
    var image: String?
    var imageHeader: String?
    var title: String?
    var likes: String?
    var dislikes: String?
    var address: String?
    var phone: String?
    var userssId: Int?
    var nivelId: Int?
    var sentimentalId: Int?
    var imagenBin: String?
    var valor : String?
    var id: Int?
}



struct GenderViewModel {
    //case male, female, ether
    var gender: String?
}

//enum GenderViewModel {
//    ///case male, female, ether
//    var gender: String?
//}

struct UserCountViewModel {
    let followers: Int
    let following: Int
    let posts: Int
}

struct IReqResPostCommentsViewModel {
    var postComments: [PostComments]?
    var status: String?

    enum CodingKeys: String, CodingKey {
        case postComments = "PostComments"
        case status
    }
}

struct PostCommentsViewModel {
    var id: Int?
    var username: String?
    var typeId, refId, userssId: Int?
    var content: String?
    var comentarioId: Int?
    var createdAt: String?
    var likes: [LikeViewModel]?

    enum CodingKeys: String, CodingKey {
        case id, username
        case typeId = "typeId"
        case refId = "refId"
        case userssId = "userssId"
        case content
        case comentarioId = "comentarioId"
        case createdAt, likes
    }
}

struct LikeViewModel {
    var username, commentIdentifier: String?
}

struct CommenttLikeViewModel {
    let username: String
    let commentIdentifier: String
}

struct FeaturePostLikeResponseViewModel {
    let postlikes: PostLikeResponseViewModel
}

struct PostLikeResponseViewModel {
    let data: [PostLikeViewModel]
    let status: String
}

struct PostLikeViewModel {
    let username: String
    let postIdentifier: String
    let text: String
    let likes: Int
}

struct DescriptionsViewModel {
    let text: String
    let likes: Int
}












// MARK: - UserPost
//struct UserPost {
//    let userpost: [Userpost]
//    let status: String
//}
//
//// MARK: - Userpost
//struct Userpost {
//    let identifier: String
//    let postType: PostType
//    let thumbnailImage: String
//    let postURL: String
//    let caption: String
//    let likeCount: [LikeCount]
//    let comments: [Comment]
//    let createDate: String
//    let taggedUsers: [Any?]
//    let owner: Owner
//}
//
//// MARK: - Comment
//struct Comment {
//    let postComments: [PostComment]
//}
//
//// MARK: - PostComment
//struct PostComment {
//    let username, postIdentifier, text: String
//    let likes: [Like]
//    let id, typeID, refID, userssID: Int
//    let content: String
//    let comentarioID: Int
//    let createdAt: String
//}
//
//// MARK: - Like
//struct Like {
//    let username, commentIdentifier: String
//}
//
//// MARK: - LikeCount
//struct LikeCount {
//    let username, postIdentifier, text: String
//    let likes: Int
//}
//
//// MARK: - Owner
//struct Owner {
//    let user: User
//    let status: String
//}
//
//// MARK: - User
//struct User {
//    let name, last, username, bio: String
//    let profilePicture: String
//    let dayOfBirth: String
//    let gender: Gender
//    let publicEmail: String
//    let counts: Counts
//    let joinDate: String
//    let countryID: Int
//    let image, imageHeader, title, likes: String
//    let dislikes, address, phone: String
//    let userssID, nivelID, sentimentalID: Int
//    let imagenBin, valor: String
//    let id: Int
//}
//
//// MARK: - Counts
//struct Counts {
//    let followers, following, posts: Int
//}
//
//// MARK: - Gender
//struct Gender {
//    let gender: String
//}
//
//// MARK: - PostType
//struct PostType {
//    let photo, video: String
//}




// /////////////////////////////////////////////////////////////////////////////////////



//enum Gender {
//    case male, female, ether
//}
//
//struct User {
//    let name: (first:String, last:String)
//    let username: String
//    let bio: String
//    let profilePicture: URL
//    let birthDate: Date
//    let gender: Gender
//    let email: String
//    let counts: UserCount
//    let joinDate: Date
//}
//
//struct UserCount {
//    let followers: Int
//    let following: Int
//    let posts: Int
//}
//
//public enum UserPostType: String {
//    case photo = "Photo"
//    case video = "Video"
//}
//
///// Represents a user post
//public struct UserPost {
//    let identifier: String
//    let postType: UserPostType
//    let thumbnailImage: URL
//    let postURL: URL // either video url resolution photo
//    let caption: String? //Subtitle
//    let likeCount: [PostLike]
//    let comments: [PostComments]
//    let createDate: Date
//    let taggedUsers: [User]
//    let owner: User
//}
//
//struct Descriptions {
//    let text: String
//    let likes: Int
//}
//
//struct PostLike {
//    let username: String
//    let postIdentifier: String
//    let text: String
//    let likes: Int
//}
//
//class PostComments {
//    var identifier: String
//    var username: String
//    var text: String
//    var createDate: Date
//    var likes: [CommenttLike]
//    
//    init(identifier: String, username:String, text:String, createDate:Date, likes:[CommenttLike]) {
//        self.identifier = identifier
//        self.username = username
//        self.text = text
//        self.createDate = createDate
//        self.likes = likes
//    }
//}
//
//struct CommenttLike {
//    let username: String
//    let commentIdentifier: String
//}



