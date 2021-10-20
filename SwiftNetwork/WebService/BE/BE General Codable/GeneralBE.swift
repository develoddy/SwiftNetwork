//
//  GeneralBE.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation

/*
// MARK: - UserPost
class UserPost: Codable {
    let status: Bool?
    let userpost: [Userpost]?

    init() {
        self.status = nil
        self.userpost = nil
    }
    
    init(status: Bool, userpost: [Userpost]) {
        self.status = status
        self.userpost = userpost
    }
}

// MARK: - Userpost
class Userpost: Codable {
    let id: Int?
    let title, content: String?
    let lat, lng: Int?
    let startAt, finishAt: String?
    let receptorTypeID, authorRefID, receptorRefID, posttTypeID: Int?
    let nivelID: Int?
    let createdAt, updatedAt: String?
    let idPostType: Int?
    let comments: [Comment]?
    let likes: [Like]?
    let taggeds: [Tagged]?
    ///let userAuthor: [User]?
    let userAuthor: User?
    let postImage: [PostImage]?
    let postType: [PostType]?

    enum CodingKeys: String, CodingKey {
        case id, title, content, lat, lng
        case startAt = "start_at"
        case finishAt = "finish_at"
        case receptorTypeID = "receptor_type_id"
        case authorRefID = "author_ref_id"
        case receptorRefID = "receptor_ref_id"
        case posttTypeID = "postt_type_id"
        case nivelID = "nivel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case idPostType = "id_post_type"
        case comments, likes, taggeds
        case userAuthor = "user_author"
        case postImage = "post_image"
        case postType = "post_type"
    }
    
    init() {
        self.id = nil
        self.title = nil
        self.content = nil
        self.lat = nil
        self.lng = nil
        self.startAt = nil
        self.finishAt = nil
        self.receptorTypeID = nil
        self.authorRefID = nil
        self.receptorRefID = nil
        self.posttTypeID = nil
        self.nivelID = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.idPostType = nil
        self.comments = nil
        self.likes = nil
        self.taggeds = nil
        self.userAuthor = nil
        self.postImage = nil
        self.postType = nil
    }

    init(id: Int, title: String, content: String, lat: Int, lng: Int, startAt: String, finishAt: String, receptorTypeID: Int, authorRefID: Int, receptorRefID: Int, posttTypeID: Int, nivelID: Int, createdAt: String, updatedAt: String, idPostType: Int, comments: [Comment], likes: [Like], taggeds: [Tagged], userAuthor: User, postImage: [PostImage], postType: [PostType]) {
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
class Comment: Codable {
    let id, typeID, refID: Int?
    let content: String?
    let usersID, comentarioID: Int?
    let createdAt, updatedAt: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case typeID = "type_id"
        case refID = "ref_id"
        case content
        case usersID = "users_id"
        case comentarioID = "comentario_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
    
    init() {
        self.id = nil
        self.typeID = nil
        self.refID = nil
        self.content = nil
        self.usersID = nil
        self.comentarioID = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.user = nil
    }

    init(id: Int, typeID: Int, refID: Int, content: String, usersID: Int, comentarioID: Int, createdAt: String, updatedAt: String, user: User) {
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
class User: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let emailVerifiedAt: String?
    let idCount: Int?
    let createdAt, updatedAt: String?
    let count: Count?

    enum CodingKeys: String, CodingKey {
        case id, name, username, email
        case emailVerifiedAt = "email_verified_at"
        case idCount = "id_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case count
    }
    
    init() {
        self.id = nil
        self.name = nil
        self.username = nil
        self.email = nil
        self.emailVerifiedAt = nil
        self.idCount = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.count = nil
    }

    init(id: Int, name: String, username: String, email: String, emailVerifiedAt: String, idCount: Int, createdAt: String, updatedAt: String, count: Count?) {
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
class Count: Codable {
    let id, followers, following, posts: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, followers, following, posts
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init() {
        self.id = nil
        self.followers = nil
        self.following = nil
        self.posts = nil
        self.createdAt = nil
        self.updatedAt = nil
    }

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
class Like: Codable {
    let id, typeID, refID, usersID: Int?
    let createdAt, updatedAt: String?
    let userlike: User?

    enum CodingKeys: String, CodingKey {
        case id
        case typeID = "type_id"
        case refID = "ref_id"
        case usersID = "users_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userlike
    }
    
    init() {
        self.id = nil
        self.typeID = nil
        self.refID = nil
        self.usersID = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.userlike = nil
    }

    init(id: Int, typeID: Int, refID: Int, usersID: Int, createdAt: String, updatedAt: String, userlike: User) {
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
class PostImage: Codable {
    let postID, imageID: Int?
    let createdAt, updatedAt: String?
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case imageID = "image_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image
    }
    
    init() {
        self.postID = nil
        self.imageID = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.image = nil
    }

    init(postID: Int, imageID: Int, createdAt: String, updatedAt: String, image: Image) {
        self.postID = postID
        self.imageID = imageID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.image = image
    }
}

// MARK: - Image
class Image: Codable {
    let id: Int?
    let src: String?
    let title, content: String?
    let imageBin: String?
    let albumID, usersID, nivelID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, src, title, content
        case imageBin = "image_bin"
        case albumID = "album_id"
        case usersID = "users_id"
        case nivelID = "nivel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init() {
        self.id = nil
        self.src = nil
        self.title = nil
        self.content = nil
        self.imageBin = nil
        self.albumID = nil
        self.usersID = nil
        self.nivelID = nil
        self.createdAt = nil
        self.updatedAt = nil
    }

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
class PostType: Codable {
    let id: Int?
    let photo, video: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, photo, video
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init() {
        self.id = nil
        self.photo = nil
        self.video = nil
        self.createdAt = nil
        self.updatedAt = nil
    }

    init(id: Int, photo: String, video: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.photo = photo
        self.video = video
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - Tagged
class Tagged: Codable {
    let id: Int?
    let name, last, username, bio: String?
    let profilePicture, dayOfBirth, publicEmail, joinDate: String?
    let countryID: Int?
    let image, imageHeader, title, likes: String?
    let dislikes, address, phone: String?
    let usersID, nivelID, sentimentalID: Int?
    let imagenBin, valor: String?
    let idPost, idGender, idCount: Int?
    let createdAt, updatedAt: String?
    let gender: Gender?

    enum CodingKeys: String, CodingKey {
        case id, name, last, username, bio
        case profilePicture = "profile_picture"
        case dayOfBirth = "day_of_birth"
        case publicEmail = "public_email"
        case joinDate = "join_date"
        case countryID = "country_id"
        case image
        case imageHeader = "image_header"
        case title, likes, dislikes, address, phone
        case usersID = "users_id"
        case nivelID = "nivel_id"
        case sentimentalID = "sentimental_id"
        case imagenBin = "imagen_bin"
        case valor
        case idPost = "id_post"
        case idGender = "id_gender"
        case idCount = "id_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case gender
    }
    
    init() {
        self.id = nil
        self.name = nil
        self.last = nil
        self.username = nil
        self.bio = nil
        self.profilePicture = nil
        self.dayOfBirth = nil
        self.publicEmail = nil
        self.joinDate = nil
        self.countryID = nil
        self.image = nil
        self.imageHeader = nil
        self.title = nil
        self.likes = nil
        self.dislikes = nil
        self.address = nil
        self.phone = nil
        self.usersID = nil
        self.nivelID = nil
        self.sentimentalID = nil
        self.imagenBin = nil
        self.valor = nil
        self.idPost = nil
        self.idGender = nil
        self.idCount = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.gender = nil
    }

    init(id: Int, name: String, last: String, username: String, bio: String, profilePicture: String, dayOfBirth: String, publicEmail: String, joinDate: String, countryID: Int, image: String, imageHeader: String, title: String, likes: String, dislikes: String, address: String, phone: String, usersID: Int, nivelID: Int, sentimentalID: Int, imagenBin: String, valor: String, idPost: Int, idGender: Int, idCount: Int, createdAt: String, updatedAt: String, gender: Gender) {
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
class Gender: Codable {
    let id: Int?
    let gender: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, gender
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init() {
        self.id = nil
        self.gender = nil
        self.createdAt = nil
        self.updatedAt = nil
    }

    init(id: Int, gender: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.gender = gender
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

*/

/* ============================================================================= */






// MARK: - UserPost
struct UserPost: Codable {
    let status: Bool?
    let userpost: [Userpost]?
}

// MARK: - Userpost
struct Userpost: Codable {
    let id: Int?
    let title, content: String?
    let lat, lng: Int?
    let startAt, finishAt: String?
    let receptorTypeID, authorRefID, receptorRefID, posttTypeID: Int?
    let nivelID: Int?
    let createdAt, updatedAt: String?
    let idPostType: Int?
    let comments: [Comment]?
    let likes: [Like]?
    let taggeds: [Tagged]?
    let userAuthor: User?
    let postImage: [PostImage]?
    let postType: PostType?

    enum CodingKeys: String, CodingKey {
        case id, title, content, lat, lng
        case startAt = "start_at"
        case finishAt = "finish_at"
        case receptorTypeID = "receptor_type_id"
        case authorRefID = "author_ref_id"
        case receptorRefID = "receptor_ref_id"
        case posttTypeID = "postt_type_id"
        case nivelID = "nivel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case idPostType = "id_post_type"
        case comments, likes, taggeds
        case userAuthor = "user_author"
        case postImage = "post_image"
        case postType = "post_type"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, typeID, refID: Int?
    let content: String?
    let usersID, comentarioID: Int?
    let createdAt, updatedAt: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case typeID = "type_id"
        case refID = "ref_id"
        case content
        case usersID = "users_id"
        case comentarioID = "comentario_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}

enum AtedAt: String, Codable {
    case the20211014T125458000000Z = "2021-10-14T12:54:58.000000Z"
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let emailVerifiedAt: String?
    let idCount: Int?
    let createdAt, updatedAt: String?
    let count: Count?

    enum CodingKeys: String, CodingKey {
        case id, name, username, email
        case emailVerifiedAt = "email_verified_at"
        case idCount = "id_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case count
    }
}

// MARK: - Count
struct Count: Codable {
    let id, followers, following, posts: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, followers, following, posts
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



// MARK: - Like
struct Like: Codable {
    let id, typeID, refID, usersID: Int?
    let createdAt, updatedAt: String?
    let userlike: User?

    enum CodingKeys: String, CodingKey {
        case id
        case typeID = "type_id"
        case refID = "ref_id"
        case usersID = "users_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userlike
    }
}

// MARK: - PostImage
struct PostImage: Codable {
    let postID, imageID: Int?
    let createdAt, updatedAt: String?
    let image: Image?

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case imageID = "image_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image
    }
}

// MARK: - Image
struct Image: Codable {
    let id: Int?
    let src: String?
    let title, content: String?
    let imageBin: String?
    let albumID, usersID, nivelID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, src, title, content
        case imageBin = "image_bin"
        case albumID = "album_id"
        case usersID = "users_id"
        case nivelID = "nivel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - PostType
struct PostType: Codable {
    let id: Int?
    let photo, video: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, photo, video
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Tagged
struct Tagged: Codable {
    let id: Int?
    let name, last, username, bio: String?
    let profilePicture, dayOfBirth, publicEmail, joinDate: String?
    let countryID: Int?
    let image, imageHeader, title, likes: String?
    let dislikes, address, phone: String?
    let usersID, nivelID, sentimentalID: Int?
    let imagenBin, valor: String?
    let idPost, idGender, idCount: Int?
    let createdAt, updatedAt: String?
    let gender: Gender?

    enum CodingKeys: String, CodingKey {
        case id, name, last, username, bio
        case profilePicture = "profile_picture"
        case dayOfBirth = "day_of_birth"
        case publicEmail = "public_email"
        case joinDate = "join_date"
        case countryID = "country_id"
        case image
        case imageHeader = "image_header"
        case title, likes, dislikes, address, phone
        case usersID = "users_id"
        case nivelID = "nivel_id"
        case sentimentalID = "sentimental_id"
        case imagenBin = "imagen_bin"
        case valor
        case idPost = "id_post"
        case idGender = "id_gender"
        case idCount = "id_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case gender
    }
}

// MARK: - Gender
struct Gender: Codable {
    let id: Int?
    let gender: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, gender
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
















/*
// MARK: - UserPost
struct UserPost: Codable {
    let status: Bool
    let userpost: [Userpost]
}

// MARK: - Userpost
struct Userpost: Codable {
    let id: Int
    let title, content: String
    let lat, lng: Int
    let startAt, finishAt: String
    let receptorTypeID, authorRefID, receptorRefID, posttTypeID: Int
    let nivelID: Int
    let createdAt, updatedAt: String
    let idPostType: Int
    let comments: [Comment]
    let likes: [Like]
    let taggeds: [Tagged]
    let userAuthor: User
    let postImage: [PostImage]
    let postType: PostType
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, lat, lng
        case startAt = "start_at"
        case finishAt = "finish_at"
        case receptorTypeID = "receptor_type_id"
        case authorRefID = "author_ref_id"
        case receptorRefID = "receptor_ref_id"
        case posttTypeID = "postt_type_id"
        case nivelID = "nivel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case idPostType = "id_post_type"
        case comments, likes, taggeds
        case userAuthor = "user_author"
        case postImage = "post_image"
        case postType = "post_type"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, typeID, refID: Int
    let content: String
    let usersID, comentarioID: Int
    let createdAt, updatedAt: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case typeID = "type_id"
        case refID = "ref_id"
        case content
        case usersID = "users_id"
        case comentarioID = "comentario_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case user
    }
}


// MARK: - User
struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let emailVerifiedAt: String
    let idCount: Int
    let createdAt, updatedAt: String
    let count: Count?

    enum CodingKeys: String, CodingKey {
        case id, name, username, email
        case emailVerifiedAt = "email_verified_at"
        case idCount = "id_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case count
    }
}

// MARK: - Count
struct Count: Codable {
    let id, followers, following, posts: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, followers, following, posts
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Like
struct Like: Codable {
    let id, typeID, refID, usersID: Int
    let createdAt, updatedAt: String
    let userlike: User

    enum CodingKeys: String, CodingKey {
        case id
        case typeID = "type_id"
        case refID = "ref_id"
        case usersID = "users_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userlike
    }
}

// MARK: - PostImage
struct PostImage: Codable {
    let postID, imageID: Int
    let createdAt, updatedAt: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case imageID = "image_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case image
    }
}

// MARK: - Image
struct Image: Codable {
    let id: Int
    let src: String
    let title, content: String
    let imageBin: String
    let albumID, usersID, nivelID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, src, title, content
        case imageBin = "image_bin"
        case albumID = "album_id"
        case usersID = "users_id"
        case nivelID = "nivel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - PostType
struct PostType: Codable {
    let id: Int
    let photo, video: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, photo, video
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Tagged
struct Tagged: Codable {
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
    let gender: Gender

    enum CodingKeys: String, CodingKey {
        case id, name, last, username, bio
        case profilePicture = "profile_picture"
        case dayOfBirth = "day_of_birth"
        case publicEmail = "public_email"
        case joinDate = "join_date"
        case countryID = "country_id"
        case image
        case imageHeader = "image_header"
        case title, likes, dislikes, address, phone
        case usersID = "users_id"
        case nivelID = "nivel_id"
        case sentimentalID = "sentimental_id"
        case imagenBin = "imagen_bin"
        case valor
        case idPost = "id_post"
        case idGender = "id_gender"
        case idCount = "id_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case gender
    }
}

// MARK: - Gender
struct Gender: Codable {
    let id: Int
    let gender: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, gender
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

*/

























































// ========================================= Antes =========================================
//struct IReqResponseUserPost: Codable {
//    var userpost: [Userpost]?
//    var status: String?
//}
//
//
//// MARK: - IReqResponseUserPost
//public struct Userpost: Codable  {
//    var identifier: String?
//    var postType: UserPostTypeCodable?
//    var thumbnailImage: String?
//    var postURL: String?
//    var caption: String?
//    var likeCount: [IReqResponsePostLike]?
//    var comments: [IReqResponsePostComments]?
//    var createDate: String?
//    var taggedUsers: [IReqResponseTaggedUsers]?
//    var owner: IReqResponseUser?
//}
//
//// MARK: - IReqResponseTaggedUsers
//struct IReqResponseTaggedUsers: Codable {
//    var user: [TaggedUsersClass]?
//    var status: String?
//}
//
//// MARK: - User
//struct TaggedUsersClass: Codable {
//    var name, last, username, bio: String?
//    var profilePicture: String?
//    var dayOfBirth: String?
//    var gender: Gender?
//    var publicEmail: String?
//    var counts: Counts?
//    var joinDate: String?
//    var countryId: Int?
//    var image, imageHeader, title, likes: String?
//    var dislikes, address, phone: String?
//    var userssID, nivelID, sentimentalID: Int?
//    var imagenBin, valor: String?
//    var id: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case name, last, username, bio, profilePicture, dayOfBirth, gender, publicEmail, counts, joinDate
//        case countryId = "countryId"
//        case image, imageHeader, title, likes, dislikes, address, phone
//        case userssID = "userssId"
//        case nivelID = "nivelId"
//        case sentimentalID = "sentimentalId"
//        case imagenBin, valor, id
//    }
//}
//
//
//
//// MARK: - User
//struct IReqResponseUser: Codable {
//    var user: UserClass?
//    var status: String?
//}
//
//// MARK: - UserClass
//struct UserClass: Codable {
//    var name, last, username, bio: String?
//    var profilePicture: String?
//    var dayOfBirth: String?
//    var gender: Gender?
//    var publicEmail: String?
//    var counts: Counts?
//    var joinDate: String?
//    var countryID: Int?
//    var image, imageHeader, title, likes: String?
//    var dislikes, address, phone: String?
//    var userssID, nivelID, sentimentalID: Int?
//    var imagenBin, valor: String?
//    var id: Int?
//}
//
//
//// MARK: - Counts
//struct Counts: Codable {
//    var followers, following, posts: Int?
//}
//
//// MARK: - Gender
//struct Gender: Codable {
//    ///case male, female, ether
//    var gender: String?
//}
//
//// MARK: - IReqResponsePostComments
//struct IReqResponsePostComments: Codable {
//    var postComments: [PostComments]?
//    var status: String?
//}
//
//// MARK: - PostComments
//struct PostComments: Codable {
//    var id: Int?
//    var username: String?
//    var typeId, refId, userssId: Int?
//    var content: String?
//    var comentarioId: Int?
//    var createdAt: String?
//    var likes: [Like]?
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
//// MARK: - Like
//struct Like: Codable {
//    var username, commentIdentifier: String?
//}
//
//// MARK: - LikeCount
//struct LikeCount: Codable {
//    let username, postIdentifier, text: String
//    let likes: Int
//}
//
//
//// MARK: - LikeCountIreqResponsePosLike
//struct IReqResponseFeaturePosLike: Codable {
//    var postlikes: IReqResponsePostLike?
//}
//
//
//// MARK: - IReqResponsePostLike
//struct IReqResponsePostLike: Codable {
//    var items: [IPostLike]?
//    var status: String?
//}
//// MARK: - PostLikeCodable
//struct IPostLike: Codable {
//    var username : String?
//    var postIdentifier: String?
//    var text: String?
//    var likes: Int?
//}
//// MARK: - UserPostTypeCodable
//struct UserPostTypeCodable: Codable {
//    let photo, video: String
//}
//// MARK: - DescriptionsCodable
//struct DescriptionsCodable: Codable  {
//    var text: String
//    var likes: Int
//}
























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
