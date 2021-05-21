//
//  GeneralBE.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 21/5/21.
//

import Foundation


// MARK: - IReqResponseUserPost
public struct IReqResponseUserPost: Codable  {
    var identifier: String?
    var postType: UserPostTypeCodable?
    var thumbnailImage: URL?
    var postURL: URL?
    var caption: String?
    var likeCount: [IReqResponsePostLike]?
    var comments: [IReqResponsePostComments]?
    var createDate: Date?
    var taggedUsers: [IReqResponseUser]?
    var owner: IReqResponseUser?
}

// MARK: - IReqResponseUser
struct IReqResponseUser: Codable {
    ///var name: (first:String?, last:String?)
    var username: String?
    var bio: String?
    var profilePicture: URL?
    var dayOfBirth: Date?
    var gender: GenderCodable?
    var publicEmail: String?
    var counts: UserCountCodable?
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
// MARK: - UserCountCodable
struct UserCountCodable: Codable {
    var followers: Int?
    var following: Int?
    var posts: Int?
}
// MARK: - GenderCodable
enum GenderCodable:Int, Codable {
    case male, female, ether
}



// MARK: - IReqResponsePostComments IReqResponsePostComments
struct IReqResponsePostComments: Codable  {
    var id: Int?
    var username: String?
    var type_id: Int?
    var ref_id: Int?
    var userss_id: Int?
    var content: String?
    var comentario_id: Int?
    var createdAt: Date?
    var likes: [CommenttLikeCodable]?
}
// MARK: - CommenttLikeCodable
struct CommenttLikeCodable: Codable  {
    var username: String?
    var commentIdentifier: String?
}



// MARK: - IReqResponsePostLike
class IReqResponsePostLike: Codable {
    var data: [PostLikeCodable]?
    var status: String?
}
// MARK: - PostLikeCodable
class PostLikeCodable: Codable {
    var username : String?
    var postIdentifier: String?
    var text: String?
    var likes: Int?
}




// MARK: - UserPostTypeCodable
public enum UserPostTypeCodable: String,Codable {
    case photo = "Photo"
    case video = "Video"
}

// MARK: - DescriptionsCodable
struct DescriptionsCodable: Codable  {
    var text: String
    var likes: Int
}
