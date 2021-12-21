//
//  UserpostViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 1/12/21.
//

import Foundation

//MARK: - UserpostViewModel
class HomeViewModel {
    
    private var apiService = APIService()
    
    public var models = [HomeFeedRenderViewModel]()
    
    static let database = DatabaseHandler.shared
    
    func userpost(userpost: [UserpostServerModel]) -> Bool  {
        
        //MARK: Userpost
        /// - Recorremos el array Padre Userpost donde contiene:
        /// - Se irán guardando los datos en las propiedades del Entity del core data.
        /// - Relationships:
        ///     - Comments [ ]
        ///     - Likes [ ]
        ///     - Taggeds [ ]
        ///     - user_author
        ///     - post_image [ ]
        ///     - post_type
        for post in userpost {
            guard let userpostEntity = HomeViewModel.database.add(CD0011_posts.self) else { return false }
            //MARK:   Post
            guard let id                = post.id,
                  let title             = post.title,
                  let content           = post.content,
                  let lat               = post.lat,
                  let lng               = post.lng,
                  let start_at          = post.startAt,
                  let finish_at         = post.finishAt,
                  let receptor_type_id  = post.receptorTypeID,
                  let author_ref_id     = post.authorRefID,
                  let receptor_ref_id   = post.receptorRefID,
                  let postt_type_id     = post.posttTypeID,
                  let nivel_id          = post.nivelID,
                  let created_at        = post.createdAt,
                  let updated_at        = post.updatedAt,
                  let id_post_type      = post.idPostType else {
                return false
            }

            userpostEntity.id                 = Int64(id)
            userpostEntity.title              = title
            userpostEntity.content            = content
            userpostEntity.lat                = Int64(lat)
            userpostEntity.lng                = Int64(lng)
            userpostEntity.start_at           = start_at
            userpostEntity.finish_at          = finish_at
            userpostEntity.receptor_type_id   = Int64(receptor_type_id)
            userpostEntity.author_ref_id      = Int64(author_ref_id)
            userpostEntity.receptor_ref_id    = Int64(receptor_ref_id)
            userpostEntity.postt_type_id      = Int64(postt_type_id)
            userpostEntity.nivel_id           = Int64(nivel_id)
            userpostEntity.created_at         = created_at
            userpostEntity.updated_at         = updated_at
            userpostEntity.id_post_type       = Int64(id_post_type)

            
            
            //MARK:  - Comments
            /// - Recorremos el array de comentarios.
            /// - Se irá guardando los datos en las propiedades del Entity del core data.
            /// - Relationships:
            ///     - User
            for coment in post.comments ?? [] {
                
                /// Core Data - Entity : Comment
                guard let commentEntity = HomeViewModel.database.add(CD0014_comments.self) else { return false }
                guard let cId            = coment.id,
                      let cIypeID        = coment.typeID,
                      let cRefID         = coment.refID,
                      let cContent       = coment.content,
                      let cUsersID       = coment.usersID,
                      let cComentarioID  = coment.comentarioID,
                      let cCreatedAt     = coment.createdAt,
                      let cUpdateAt      = coment.updatedAt,
                      let cUser          = coment.user else {
                    return false
                }
                commentEntity.cd14_id               = Int64(cId)
                commentEntity.cd14_type_id          = Int64(cIypeID)
                commentEntity.cd14_ref_id           = Int64(cRefID)
                commentEntity.cd14_content          = cContent
                commentEntity.cd14_users_id         = Int64(cUsersID)
                commentEntity.cd14_comentario_id    = Int64(cComentarioID)
                commentEntity.cd14_created_at       = cCreatedAt
                commentEntity.cd14_updated_at       = cUpdateAt

                /// Core Data - Entity : User
                guard let userEntity = HomeViewModel.database.add(CD0001_users.self) else { return false}
                guard let uId               = cUser.id,
                      let uName             = cUser.name,
                      let uUsername         = cUser.username,
                      let uEmail            = cUser.email,
                      let uEmailVerifiedAt  = cUser.emailVerifiedAt,
                      let uIdCount          = cUser.idCount,
                      let uCreatedAt        = cUser.createdAt,
                      let uUpdatedAt        = cUser.updatedAt else {
                    return false
                }

                userEntity.cd01_id                  = Int64(uId)
                userEntity.cd01_name                = uName
                userEntity.cd01_username            = uUsername
                userEntity.cd01_email               = uEmail
                userEntity.cd01_email_verified_at   = uEmailVerifiedAt
                userEntity.cd01_id_count            = Int64(uIdCount)
                userEntity.cd01_created_at          = uCreatedAt
                userEntity.cd01_updated_at          = uUpdatedAt

                commentEntity.addToCd14_user(userEntity) /// User add to commentEntity.user
                userpostEntity.addToComments(commentEntity) /// Comments add to userpostEntity.comments
            }


            
            //MARK:  - Likes
            /// - Recorremos el array de Likes.
            /// - Se irá guardando los datos en las propiedades del Entity del core data.
            /// - Relationships:
            ///     - Userlike
            for like in post.likes ?? [] {
                /// Core Data - Entity : Like.
                guard let likeEntity = HomeViewModel.database.add(CD0013_likes.self) else { return false }
                guard let lId           = like.id,
                      let ltypeId       = like.typeID,
                      let lRefId        = like.refID,
                      let lUserId       = like.usersID,
                      let lCreatedAt    = like.createdAt,
                      let lUpdateAt     = like.updatedAt,
                      let lUser         = like.userlike else {
                          return false
                }
                likeEntity.cd13_id          = Int64(lId)
                likeEntity.cd13_type_id     = Int64(ltypeId)
                likeEntity.cd13_ref_id      = Int64(lRefId)
                likeEntity.cd13_users_id    = Int64(lUserId)
                likeEntity.cd13_created_at  = lCreatedAt
                likeEntity.cd13_updated_at  = lUpdateAt
                
                /// Core Data - Entity : User.
                guard let userEntity = HomeViewModel.database.add(CD0001_users.self) else { return false}
                guard let uId               = lUser.id,
                      let uName             = lUser.name,
                      let uUsername         = lUser.username,
                      let uEmail            = lUser.email,
                      let uEmailVerifiedAt  = lUser.emailVerifiedAt,
                      let uIdCount          = lUser.idCount,
                      let uCreatedAt        = lUser.createdAt,
                      let uUpdatedAt        = lUser.updatedAt else {
                    return false
                }

                userEntity.cd01_id                  = Int64(uId)
                userEntity.cd01_name                = uName
                userEntity.cd01_username            = uUsername
                userEntity.cd01_email               = uEmail
                userEntity.cd01_email_verified_at   = uEmailVerifiedAt
                userEntity.cd01_id_count            = Int64(uIdCount)
                userEntity.cd01_created_at          = uCreatedAt
                userEntity.cd01_updated_at          = uUpdatedAt
                
                likeEntity.addToCd13_userlike(userEntity)  /// User add to Likes.userlikes.
                userpostEntity.addToLikes(likeEntity) /// Likes add to userpostEntity.likes.
            }
            
            
            //MARK: - Taggeds
            /// - Se irá guardando los datos en las propiedades del Entity del core data.
            /// - Relationships:
            ///     - Gender
            for tagged in post.taggeds ?? [] {
                /// Core Data - Entity : Taggeds.
                guard let taggedsEntity = HomeViewModel.database.add(CD0023_taggeds.self) else { return false }
                guard let tId               = tagged.id             ,
                      let tName             = tagged.name           ,
                      let tLast             = tagged.last           ,
                      let tUsername         = tagged.username       ,
                      let tBio              = tagged.bio            ,
                      let tProfilePicture   = tagged.profilePicture ,
                      let tDayOfBirth       = tagged.dayOfBirth     ,
                      let tPublicMail       = tagged.publicEmail    ,
                      let tJoinDate         = tagged.joinDate       ,
                      let tCountryId        = tagged.countryID      ,
                      let tImage            = tagged.image          ,
                      let tImageHeader      = tagged.imageHeader    ,
                      let tTitle            = tagged.title          ,
                      let tLikes            = tagged.likes          ,
                      let tDislikes         = tagged.dislikes       ,
                      let tAddress          = tagged.address        ,
                      let tPhone            = tagged.phone          ,
                      let tUsersId          = tagged.usersID        ,
                      let tNivelId          = tagged.nivelID        ,
                      let tSentimentalId    = tagged.sentimentalID  ,
                      let tImageBin         = tagged.imagenBin      ,
                      let tValor            = tagged.valor          ,
                      let tIdPost           = tagged.idPost         ,
                      let tIdGender         = tagged.idGender       ,
                      let tIdCount          = tagged.idCount        ,
                      let tCreatedAt        = tagged.createdAt      ,
                      let tUpdateAt         = tagged.updatedAt else {
                      //let gender          = tagged.gender
                    return false
                }
                
                taggedsEntity.cd23_id               = Int64(tId)
                taggedsEntity.cd23_name             = tName
                taggedsEntity.cd23_last             = tLast
                taggedsEntity.cd23_username         = tUsername
                taggedsEntity.cd23_bio              = tBio
                taggedsEntity.cd23_profile_picture  = tProfilePicture
                taggedsEntity.cd23_day_of_birth     = tDayOfBirth
                taggedsEntity.cd23_public_email     = tPublicMail
                taggedsEntity.cd23_join_date        = tJoinDate
                taggedsEntity.cd23_country_id       = Int64(tCountryId)
                taggedsEntity.cd23_image            = tImage
                taggedsEntity.cd23_image_header     = tImageHeader
                taggedsEntity.cd23_title            = tTitle
                taggedsEntity.cd23_likes            = tLikes
                taggedsEntity.cd23_dislikes         = tDislikes
                taggedsEntity.cd23_address          = tAddress
                taggedsEntity.cd23_phone            = tPhone
                taggedsEntity.cd23_users_id         = Int64(tUsersId)
                taggedsEntity.cd23_nivel_id         = Int64(tNivelId)
                taggedsEntity.cd23_sentimental_id   = Int64(tSentimentalId)
                taggedsEntity.cd23_imagen_bin       = tImageBin
                taggedsEntity.cd23_valor            = tValor
                taggedsEntity.cd23_id_post          = Int64(tIdPost)
                taggedsEntity.cd23_id_gender        = Int64(tIdGender)
                taggedsEntity.cd23_id_count         = Int64(tIdCount)
                taggedsEntity.cd23_created_at       = tCreatedAt
                taggedsEntity.cd23_updated_at       = tUpdateAt
                
                userpostEntity.addToTaggeds(taggedsEntity) /// Taggeds add to userpostEntity.taggeds.
            }
        } // End for Userpost
        
        // Saved
        if HomeViewModel.database.save() {
            return true
        } else {
            return false
        }
    }
    
    func syncUsersPost(token: String, completion: @escaping () -> ()) {
        apiService.syncUsersPost(token: token) {(result) in
            switch result {
            case .success(let model):
                ///model.forEach { $0.store() }
                ///self.userpost(userpost: model) == true ? print("Post SI insertado en Core data post") :
                let insertCore = self.userpost(userpost: model)
                if insertCore {
                    self.insertCoreDataToModel()
                } else {
                    print("Datos NO insertado en core data post")
                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
    
    
    
    func insertCoreDataToModel () {
        let userpost = HomeViewModel.database.fetch(CD0011_posts.self)
        for items in userpost {
            guard let comments = items.comments else { return }
            let viewModel = HomeFeedRenderViewModel(
                header: PostRenderViewModel(renderType: .header(provider: items)),
                post: PostRenderViewModel(renderType: .primaryContent(provider: items)),
                actions: PostRenderViewModel(renderType: .actions(provider: items)),
                descriptions: PostRenderViewModel(renderType: .descriptions(post: items)),
                comments: PostRenderViewModel(renderType: .comments(comments: comments )),
                footer: PostRenderViewModel(renderType: .footer(footer: items)))
            self.models.append(viewModel)
        }
    }
        
        
        
        
        
        
    ///Api Rest.
    ///En esta función llamamos al Api rest para traes los datos de la DataBase,
    ///Desde handleNotAuthenticated ontenemos tanto el token como el email del usario que está conectado a la App.
//    func fetchUserpostData(token: String, completion: @escaping () -> ()) {
//        apiService.apiUserPost(token: token) {(result) in
//            switch result {
//            case .success(let model):
//                guard let userpost = model.userpost else { return }
//                for items in userpost {
//                    guard let comments = items.comments else { return }
//                    let viewModel = HomeFeedRenderViewModel(
//                        header      : PostRenderViewModel(renderType: .header(provider: items)),
//                        post        : PostRenderViewModel(renderType: .primaryContent(provider: items)),
//                        actions     : PostRenderViewModel(renderType: .actions(provider: items)),
//                        descriptions: PostRenderViewModel(renderType: .descriptions(post: items)),
//                        comments    : PostRenderViewModel(renderType: .comments(comments: comments)),
//                        footer      : PostRenderViewModel(renderType: .footer(footer: items)))
//                    self.models.append(viewModel)
//                }
//                completion()
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    
    
    func numberOfSections() -> Int {
        return models.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if models.count != 0 {
            return models.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> HomeFeedRenderViewModel {
        return models[indexPath.row]
    }
    
   
}
