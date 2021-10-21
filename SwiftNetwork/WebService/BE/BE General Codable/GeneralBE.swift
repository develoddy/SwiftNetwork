//
//  GeneralBE.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation


/*
// MARK: - UserPost
struct UserPost: Codable {
    let status: Bool
    let userpost: [User]
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
    let profile: Profile?
    let posts: [Post]?
    let count: Count?

    enum CodingKeys: String, CodingKey {
        case id, name, username, email
        case emailVerifiedAt = "email_verified_at"
        case idCount = "id_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profile, posts, count
    }
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let title, content: String
    let lat, lng: Int
    let startAt, finishAt: String
    let receptorTypeID, authorRefID, receptorRefID, posttTypeID: Int
    let nivelID: Int
    let createdAt, updatedAt: String
    let idPostType: Int
    let userAuthor: User
    let comments: [Comment]
    let postImage: [PostImage]
    let likes: [Like]
    let taggeds: [Tagged]
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
        case userAuthor = "user_author"
        case comments
        case postImage = "post_image"
        case likes, taggeds
        case postType = "post_type"
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



// MARK: - Profile
struct Profile: Codable {
    let id: Int
    let dayOfBirth, gender, image, imageHeader: String
    let title, bio, likes, dislikes: String
    let address, phone: String
    let publicEmail: String
    let data, valor: String
    let usersID, countryID, nivelID, sentimentalID: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case dayOfBirth = "day_of_birth"
        case gender, image
        case imageHeader = "image_header"
        case title, bio, likes, dislikes, address, phone
        case publicEmail = "public_email"
        case data, valor
        case usersID = "users_id"
        case countryID = "country_id"
        case nivelID = "nivel_id"
        case sentimentalID = "sentimental_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
*/
























///////////////////////// Semi original //////////////////////////

 
 
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

