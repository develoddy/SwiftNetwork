//
//  GeneralBE.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation

struct IReqResponseUserPost: Codable {
    var userpost: [Userpost]?
    var status: String?
}

// MARK: - IReqResponseUserPost
public struct Userpost: Codable  {
    var identifier: String?
    var postType: UserPostTypeCodable?
    var thumbnailImage: String?
    var postURL: String?
    var caption: String?
    var likeCount: [IReqResponsePostLike]?
    var comments: [IReqResponsePostComments]?
    var createDate: String?
    var taggedUsers: [IReqResponseTaggedUsers]?
    var owner: IReqResponseUser?
}

// MARK: - IReqResponseTaggedUsers
struct IReqResponseTaggedUsers: Codable {
    var user: [TaggedUsersClass]?
    var status: String?
}

// MARK: - User
struct TaggedUsersClass: Codable {
    var name, last, username, bio: String?
    var profilePicture: String?
    var dayOfBirth: String?
    var gender: Gender?
    var publicEmail: String?
    var counts: Counts?
    var joinDate: String?
    var countryId: Int?
    var image, imageHeader, title, likes: String?
    var dislikes, address, phone: String?
    var userssID, nivelID, sentimentalID: Int?
    var imagenBin, valor: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case name, last, username, bio, profilePicture, dayOfBirth, gender, publicEmail, counts, joinDate
        case countryId = "countryId"
        case image, imageHeader, title, likes, dislikes, address, phone
        case userssID = "userssId"
        case nivelID = "nivelId"
        case sentimentalID = "sentimentalId"
        case imagenBin, valor, id
    }
}



// MARK: - User
struct IReqResponseUser: Codable {
    var user: UserClass?
    var status: String?
}

// MARK: - UserClass
struct UserClass: Codable {
    var name, last, username, bio: String?
    var profilePicture: String?
    var dayOfBirth: String?
    var gender: Gender?
    var publicEmail: String?
    var counts: Counts?
    var joinDate: String?
    var countryID: Int?
    var image, imageHeader, title, likes: String?
    var dislikes, address, phone: String?
    var userssID, nivelID, sentimentalID: Int?
    var imagenBin, valor: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case name, last, username, bio, profilePicture, dayOfBirth, gender, publicEmail, counts, joinDate
        case countryID = "countryId"
        case image, imageHeader, title, likes, dislikes, address, phone
        case userssID = "userssId"
        case nivelID = "nivelId"
        case sentimentalID = "sentimentalId"
        case imagenBin, valor, id
    }
}





// MARK: - Counts
struct Counts: Codable {
    var followers, following, posts: Int?
}

// MARK: - Gender
struct Gender: Codable {
    ///case male, female, ether
    var gender: String?
}

// MARK: - IReqResponsePostComments
struct IReqResponsePostComments: Codable {
    var postComments: [PostComments]?
    var status: String?
}

// MARK: - PostComments
struct PostComments: Codable {
    var id: Int?
    var username: String?
    var typeId, refId, userssId: Int?
    var content: String?
    var comentarioId: Int?
    var createdAt: String?
    var likes: [Like]?

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

// MARK: - Like
struct Like: Codable {
    var username, commentIdentifier: String?
}

// MARK: - LikeCount
struct LikeCount: Codable {
    let username, postIdentifier, text: String
    let likes: Int
}


// MARK: - LikeCountIreqResponsePosLike
struct IReqResponseFeaturePosLike: Codable {
    var postlikes: IReqResponsePostLike?
}


// MARK: - IReqResponsePostLike
struct IReqResponsePostLike: Codable {
    var items: [IPostLike]?
    var status: String?
}
// MARK: - PostLikeCodable
struct IPostLike: Codable {
    var username : String?
    var postIdentifier: String?
    var text: String?
    var likes: Int?
}
// MARK: - UserPostTypeCodable
struct UserPostTypeCodable: Codable {
    let photo, video: String
}
// MARK: - DescriptionsCodable
struct DescriptionsCodable: Codable  {
    var text: String
    var likes: Int
}




/*
 // This file was generated from JSON Schema using quicktype, do not modify it directly.
 // To parse the JSON, add this file to your project and do:
 //
 //   let iReqResponseUserPost = try? newJSONDecoder().decode(IReqResponseUserPost.self, from: jsonData)

 import Foundation

 // MARK: - IReqResponseUserPost
 struct IReqResponseUserPost: Codable {
     let userpost: [Userpost]
     let status: String
 }

 // MARK: - Userpost
 struct Userpost: Codable {
     let identifier: String
     let postType: PostType
     let thumbnailImage: String
     let postURL: String
     let caption: String
     let likeCount: [LikeCount]
     let comments: [Comment]
     let createDate: String
     let taggedUsers: [TaggedUser]
     let owner: Owner
 }

 // MARK: - Comment
 struct Comment: Codable {
     let postComments: [PostComment]

     enum CodingKeys: String, CodingKey {
         case postComments = "PostComments"
     }
 }

 // MARK: - PostComment
 struct PostComment: Codable {
     let username, postIdentifier, text: String
     let likes: [Like]
     let id, typeID, refID, userssID: Int
     let content: String
     let comentarioID: Int
     let createdAt: String

     enum CodingKeys: String, CodingKey {
         case username, postIdentifier, text, likes, id
         case typeID = "typeId"
         case refID = "refId"
         case userssID = "userssId"
         case content
         case comentarioID = "comentarioId"
         case createdAt
     }
 }

 // MARK: - Like
 struct Like: Codable {
     let username, commentIdentifier: String
 }

 // MARK: - LikeCount
 struct LikeCount: Codable {
     let username, postIdentifier, text: String
     let likes: Int
 }

 // MARK: - Owner
 struct Owner: Codable {
     let user: User
     let status: String
 }

 // MARK: - User
 struct User: Codable {
     let name, last, username, bio: String
     let profilePicture: String
     let dayOfBirth: String
     let gender: Gender
     let publicEmail: String
     let counts: Counts
     let joinDate: String
     let countryID: Int
     let image, imageHeader, title, likes: String
     let dislikes, address, phone: String
     let userssID, nivelID, sentimentalID: Int
     let imagenBin, valor: String
     let id: Int

     enum CodingKeys: String, CodingKey {
         case name, last, username, bio, profilePicture, dayOfBirth, gender, publicEmail, counts, joinDate
         case countryID = "countryId"
         case image, imageHeader, title, likes, dislikes, address, phone
         case userssID = "userssId"
         case nivelID = "nivelId"
         case sentimentalID = "sentimentalId"
         case imagenBin, valor, id
     }
 }

 // MARK: - Counts
 struct Counts: Codable {
     let followers, following, posts: Int
 }

 // MARK: - Gender
 struct Gender: Codable {
     let gender: String
 }

 // MARK: - PostType
 struct PostType: Codable {
     let photo, video: String
 }

 // MARK: - TaggedUser
 struct TaggedUser: Codable {
     let user: [User]
     let status: String
 }


*/
