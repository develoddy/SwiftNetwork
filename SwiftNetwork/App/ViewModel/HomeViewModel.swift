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
        for post in userpost {
            guard let userpostEntity = HomeViewModel.database.add(CD0011_posts.self) else { return false }
            //MARK:  Post
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

            //MARK:  Comments
            for coment in post.comments ?? [] {
                /// Coment
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

                /// User
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
                userpostEntity.addToComments(commentEntity) ///Comments add to userpostEntity.comments
            }


            //MARK: Likes
            for like in post.likes ?? [] {
                guard let likeEntity = HomeViewModel.database.add(CD0013_likes.self) else { return false }
                guard let lId           = like.id,
                      let ltypeId       = like.typeID,
                      let lRefId        = like.refID,
                      let lUserId       = like.usersID,
                      let lCreatedAt    = like.createdAt,
                      let lUpdateAt     = like.updatedAt else {
                          return false
                }
                likeEntity.cd13_id          = Int64(lId)
                likeEntity.cd13_type_id     = Int64(ltypeId)
                likeEntity.cd13_ref_id      = Int64(lRefId)
                likeEntity.cd13_users_id    = Int64(lUserId)
                likeEntity.cd13_created_at  = lCreatedAt
                likeEntity.cd13_updated_at  = lUpdateAt

                userpostEntity.addToLikes(likeEntity) /// Likes add to userpostEntity.likes.s
            }
        }
        
        
        
        //Saved
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
                self.userpost(userpost: model) == true ? print("Post SI insertado en Core data post") : print("Datos NO insertado en core data post")
               
                ///HomeViewModel.database.save()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
    
    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    ///Api Rest.
    ///En esta función llamamos al Api rest para traes los datos de la DataBase,
    ///Desde handleNotAuthenticated ontenemos tanto el token como el email del usario que está conectado a la App.
    func fetchUserpostData(token: String, completion: @escaping () -> ()) {
        apiService.apiUserPost(token: token) {(result) in
            switch result {
            case .success(let model):
                guard let userpost = model.userpost else { return }
                for items in userpost {
                    //guard let user = items.userAuthor else { return }
                    guard let comments = items.comments else { return }
                    let viewModel = HomeFeedRenderViewModel(
                        header      : PostRenderViewModel(renderType: .header(provider: items)),
                        post        : PostRenderViewModel(renderType: .primaryContent(provider: items)),
                        actions     : PostRenderViewModel(renderType: .actions(provider: items)),
                        descriptions: PostRenderViewModel(renderType: .descriptions(post: items)),
                        comments    : PostRenderViewModel(renderType: .comments(comments: comments)),
                        footer      : PostRenderViewModel(renderType: .footer(footer: items)))
                    self.models.append(viewModel)
                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
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
