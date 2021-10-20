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



// MARK: - UserPost
class UserPostViewModel {
    let status: Bool
    let userpost: [UserpostViewModel]

    init(status: Bool, userpost: [UserpostViewModel]) {
        self.status = status
        self.userpost = userpost
    }
}

// MARK: - Userpost
class UserpostViewModel {
    let id: Int
    let title, content: String
    let lat, lng: Int
    let startAt, finishAt: String
    let receptorTypeID, authorRefID, receptorRefID, posttTypeID: Int
    let nivelID: Int
    let createdAt, updatedAt: String
    let idPostType: Int
    let comments: [CommentViewModel]
    let likes: [LikeViewModel]
    let taggeds: [TaggedViewModel]
    let userAuthor: UserViewModel
    let postImage: [PostImageViewModel]
    let postType: [PostTypeViewModel]

    init(id: Int, title: String, content: String, lat: Int, lng: Int, startAt: String, finishAt: String, receptorTypeID: Int, authorRefID: Int, receptorRefID: Int, posttTypeID: Int, nivelID: Int, createdAt: String, updatedAt: String, idPostType: Int, comments: [CommentViewModel], likes: [LikeViewModel], taggeds: [TaggedViewModel], userAuthor: UserViewModel, postImage: [PostImageViewModel], postType: [PostTypeViewModel]) {
        self.id = id
        self.title = title
        self.content = content
        self.lat = lat
        self.lng = lng
        self.startAt = startAt
        self.finishAt = finishAt
        self.receptorTypeID = receptorTypeID
        self.authorRefID = authorRefID
        self.receptorRefID = receptorRefID
        self.posttTypeID = posttTypeID
        self.nivelID = nivelID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.idPostType = idPostType
        self.comments = comments
        self.likes = likes
        self.taggeds = taggeds
        self.userAuthor = userAuthor
        self.postImage = postImage
        self.postType = postType
    }
}

// MARK: - Comment
class CommentViewModel {
    let id, typeID, refID: Int
    let content: String
    let usersID, comentarioID: Int
    let createdAt, updatedAt: String
    let user: UserViewModel

    init(id: Int, typeID: Int, refID: Int, content: String, usersID: Int, comentarioID: Int, createdAt: String, updatedAt: String, user: UserViewModel) {
        self.id = id
        self.typeID = typeID
        self.refID = refID
        self.content = content
        self.usersID = usersID
        self.comentarioID = comentarioID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.user = user
    }
}


// MARK: - User
class UserViewModel {
    let id: Int
    let name: String
    let username: String
    let email: String
    let emailVerifiedAt: String
    let idCount: Int
    let createdAt, updatedAt: String
    let count: CountViewModel?
    

    init(id: Int, name: String, username: String, email: String, emailVerifiedAt: String, idCount: Int, createdAt: String, updatedAt: String, count: CountViewModel?) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.emailVerifiedAt = emailVerifiedAt
        self.idCount = idCount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.count = count
    }
}

// MARK: - Count
class CountViewModel {
    let id, followers, following, posts: Int
    let createdAt, updatedAt: String

    init(id: Int, followers: Int, following: Int, posts: Int, createdAt: String, updatedAt: String) {
        self.id = id
        self.followers = followers
        self.following = following
        self.posts = posts
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


// MARK: - Like
class LikeViewModel {
    let id, typeID, refID, usersID: Int
    let createdAt, updatedAt: String
    let userlike: UserViewModel

    init(id: Int, typeID: Int, refID: Int, usersID: Int, createdAt: String, updatedAt: String, userlike: UserViewModel) {
        self.id = id
        self.typeID = typeID
        self.refID = refID
        self.usersID = usersID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.userlike = userlike
    }
}

// MARK: - PostImage
class PostImageViewModel {
    let postID, imageID: Int
    let createdAt, updatedAt: String
    let image: ImageViewModel

    init(postID: Int, imageID: Int, createdAt: String, updatedAt: String, image: ImageViewModel) {
        self.postID = postID
        self.imageID = imageID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.image = image
    }
}

// MARK: - Image
class ImageViewModel {
    let id: Int
    let src: String
    let title, content: String
    let imageBin: String
    let albumID, usersID, nivelID: Int
    let createdAt, updatedAt: String

    init(id: Int, src: String, title: String, content: String, imageBin: String, albumID: Int, usersID: Int, nivelID: Int, createdAt: String, updatedAt: String) {
        self.id = id
        self.src = src
        self.title = title
        self.content = content
        self.imageBin = imageBin
        self.albumID = albumID
        self.usersID = usersID
        self.nivelID = nivelID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - PostType
class PostTypeViewModel {
    let id: Int
    let photo, video: String
    let createdAt, updatedAt: String

    init(id: Int, photo: String, video: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.photo = photo
        self.video = video
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


public enum UserPostTypeViewModel: String {
    case photo = "Photo"
    case video = "Video"
}


// MARK: - Tagged
class TaggedViewModel {
    let id: Int
    let name, last, username, bio: String
    let profilePicture, dayOfBirth, publicEmail, joinDate: String
    let countryID: Int
    let image, imageHeader, title, likes: String
    let dislikes, address, phone: String
    let usersID, nivelID, sentimentalID: Int
    let imagenBin, valor: String
    let idPost, idGender, idCount: Int
    let createdAt, updatedAt: String
    let gender: GenderViewModel

    init(id: Int, name: String, last: String, username: String, bio: String, profilePicture: String, dayOfBirth: String, publicEmail: String, joinDate: String, countryID: Int, image: String, imageHeader: String, title: String, likes: String, dislikes: String, address: String, phone: String, usersID: Int, nivelID: Int, sentimentalID: Int, imagenBin: String, valor: String, idPost: Int, idGender: Int, idCount: Int, createdAt: String, updatedAt: String, gender: GenderViewModel) {
        self.id = id
        self.name = name
        self.last = last
        self.username = username
        self.bio = bio
        self.profilePicture = profilePicture
        self.dayOfBirth = dayOfBirth
        self.publicEmail = publicEmail
        self.joinDate = joinDate
        self.countryID = countryID
        self.image = image
        self.imageHeader = imageHeader
        self.title = title
        self.likes = likes
        self.dislikes = dislikes
        self.address = address
        self.phone = phone
        self.usersID = usersID
        self.nivelID = nivelID
        self.sentimentalID = sentimentalID
        self.imagenBin = imagenBin
        self.valor = valor
        self.idPost = idPost
        self.idGender = idGender
        self.idCount = idCount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.gender = gender
    }
}

// MARK: - Gender
class GenderViewModel {
    let id: Int
    let gender: String
    let createdAt, updatedAt: String

    init(id: Int, gender: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.gender = gender
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

























//struct UserPost {
//    let userpost: [UserPostViewModel]
//    let status: String
//}
//
//
//public struct UserPostViewModel {
//    let identifier: String
//    let postType: UserPostTypeViewModel
//    let thumbnailImage: URL
//    let postURL: URL
//    let caption: String?
//    let likeCount: [PostLikeViewModel]
//    let comments: [PostCommentsViewModel]
//    let createDate: Date
//    let taggedUsers: [UserViewModel]
//    let owner: UserViewModel
//}
//
//public enum UserPostTypeViewModel: String {
//    case photo = "Photo"
//    case video = "Video"
//}
//
//struct UserViewModel {
//    ///var name: (first:String, last:String)?
//    var name, last: String?
//    var username: String?
//    var bio: String?
//    var profilePicture: URL?
//    var dayOfBirth: Date?
//    var gender: GenderViewModel?
//    var publicEmail: String?
//    var counts: UserCountViewModel?
//    var joinDate: Date?
//    var countryId: Int?
//    var image: String?
//    var imageHeader: String?
//    var title: String?
//    var likes: String?
//    var dislikes: String?
//    var address: String?
//    var phone: String?
//    var userssId: Int?
//    var nivelId: Int?
//    var sentimentalId: Int?
//    var imagenBin: String?
//    var valor : String?
//    var id: Int?
//}
//
//
//
//struct GenderViewModel {
//    //case male, female, ether
//    var gender: String?
//}
//
////enum GenderViewModel {
////    ///case male, female, ether
////    var gender: String?
////}
//
//struct UserCountViewModel {
//    let followers: Int
//    let following: Int
//    let posts: Int
//}
//
//struct IReqResPostCommentsViewModel {
//    var postComments: [PostComments]?
//    var status: String?
//
//    enum CodingKeys: String, CodingKey {
//        case postComments = "PostComments"
//        case status
//    }
//}
//
//struct PostCommentsViewModel {
//    var id: Int?
//    var username: String?
//    var typeId, refId, userssId: Int?
//    var content: String?
//    var comentarioId: Int?
//    var createdAt: String?
//    var likes: [LikeViewModel]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, username
//        case typeId = "typeId"
//        case refId = "refId"
//        case userssId = "userssId"
//        case content
//        case comentarioId = "comentarioId"
//        case createdAt, likes
//    }
//}
//
//struct LikeViewModel {
//    var username, commentIdentifier: String?
//}
//
//struct CommenttLikeViewModel {
//    let username: String
//    let commentIdentifier: String
//}
//
//struct FeaturePostLikeResponseViewModel {
//    let postlikes: PostLikeResponseViewModel
//}
//
//struct PostLikeResponseViewModel {
//    let data: [PostLikeViewModel]
//    let status: String
//}
//
//struct PostLikeViewModel {
//    let username: String
//    let postIdentifier: String
//    let text: String
//    let likes: Int
//}
//
//struct DescriptionsViewModel {
//    let text: String
//    let likes: Int
//}












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



