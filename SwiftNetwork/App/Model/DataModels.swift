//
//  DataModels.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 18/10/21.
//

import UIKit

class DataModels: NSObject {
    
    
    /*static let shared = DataModels()
    
    private var modelsPostTypeViewModel = [PostTypeViewModel]()
        
    private var modelsPostImageViewModel = [PostImageViewModel]()
    
    private var modelsTaggedViewModel = [TaggedViewModel]()
    
    private var modelsLikeViewModel = [LikeViewModel]()
    
    private var modelsCommentViewModel = [CommentViewModel]()
    
    
    private var modelsUserpostViewModel = [UserpostViewModel]()
    
    
    ///Se gestiona los datos de DataBase
    ///UpdateUI
    public func updateUI(with model: [Userpost], completion: @escaping ([UserpostViewModel]) -> Void ) {
        ///Post Type View Model
        for items in model {
            guard let posttype = items.postType else { return }
            for items in posttype {
                let posttype = PostTypeViewModel(id: items.id ?? 0, photo: items.photo ?? "", video: items.video ?? "", createdAt: items.createdAt ?? "", updatedAt: items.updatedAt ?? "")
                self.modelsPostTypeViewModel.append(posttype)
            }
        }
        
        ///Post Image View Model
        /*for items in model {
            guard let postimage = items.postImage else { return }
            for items in postimage {
                let image = ImageViewModel(id: items.image?.id ?? 0, src: items.image?.src ?? "", title: items.image?.title ?? "", content: items.image?.content ?? "", imageBin: items.image?.imageBin ?? "", albumID: items.image?.albumID ?? 0, usersID: items.image?.usersID ?? 0, nivelID: items.image?.nivelID ?? 0, createdAt: items.image?.createdAt ?? "", updatedAt: items.image?.updatedAt ?? "")
                
                let postimage = PostImageViewModel(postID: items.postID ?? 0, imageID: items.imageID ?? 0, createdAt: items.createdAt ?? "", updatedAt: items.updatedAt ?? "", image: image)
                
                self.modelsPostImageViewModel.append(postimage)
            }
        }*/
        
        ///Taggeds View Model
        for items in model {
            guard let taggeds = items.taggeds else { return }
            for items in taggeds {
                let gender = GenderViewModel(id: items.gender?.id ?? 0, gender: items.gender?.gender ?? "", createdAt: items.gender?.createdAt ?? "", updatedAt: items.gender?.updatedAt ?? "")
                
                let taggeds = TaggedViewModel(id: items.id ?? 0, name: items.name ?? "", last: items.last ?? "", username: items.username ?? "", bio: items.bio ?? "", profilePicture: items.profilePicture ?? "", dayOfBirth: items.dayOfBirth ?? "", publicEmail: items.publicEmail ?? "", joinDate: items.joinDate ?? "", countryID: items.countryID ?? 0, image: items.image ?? "", imageHeader: items.imageHeader ?? "", title: items.title ?? "", likes: items.likes ?? "", dislikes: items.dislikes ?? "", address: items.address ?? "", phone: items.phone ?? "", usersID: items.usersID ?? 0, nivelID: items.nivelID ?? 0, sentimentalID: items.sentimentalID ?? 0, imagenBin: items.imagenBin ?? "", valor: items.valor ?? "", idPost: items.idPost ?? 0, idGender: items.idGender ?? 0, idCount: items.idCount ?? 0, createdAt: items.createdAt ?? "", updatedAt: items.updatedAt ?? "", gender: gender)
                
                self.modelsTaggedViewModel.append(taggeds)
            }
        }
        
        ///Like View Model
        for items in model {
            guard let likes = items.likes else { return }
            for items in likes {
                let count = CountViewModel(id: items.userlike?.count?.id ?? 00, followers: items.userlike?.count?.followers ?? 0, following: items.userlike?.count?.following ?? 0, posts: items.userlike?.count?.posts ?? 0, createdAt: items.userlike?.count?.createdAt ?? "", updatedAt: items.userlike?.count?.updatedAt ?? "")
                
                let user = UserViewModel(id: items.userlike?.id ?? 0, name: items.userlike?.name ?? "", username: items.userlike?.username ?? "", email: items.userlike?.email ?? "", emailVerifiedAt: items.userlike?.emailVerifiedAt ?? "", idCount: items.userlike?.idCount ?? 0, createdAt: items.userlike?.createdAt ?? "", updatedAt: items.userlike?.updatedAt ?? "", count: count)
                
                let likes = LikeViewModel(id: items.id ?? 0, typeID: items.typeID ?? 0, refID: items.refID ?? 0, usersID: items.usersID ?? 0, createdAt: items.createdAt ?? "", updatedAt: items.updatedAt ?? "", userlike: user)
                
                self.modelsLikeViewModel.append(likes)
            }
        }
        
        ///Comments View Model
        for items in model {
            guard let comments = items.comments else { return }
            for items in comments {
                let count = CountViewModel(id: items.user?.count?.id ?? 0, followers: items.user?.count?.followers ?? 0, following: items.user?.count?.following ?? 0, posts: items.user?.count?.posts ?? 0, createdAt: items.user?.count?.createdAt ?? "", updatedAt: items.user?.count?.updatedAt ?? "")
                
                let user = UserViewModel(id: items.user?.id ?? 0, name: items.user?.name ?? "", username: items.user?.username ?? "", email: items.user?.email ?? "", emailVerifiedAt: items.user?.emailVerifiedAt ?? "", idCount: items.user?.idCount ?? 0, createdAt: items.user?.createdAt ?? "", updatedAt: items.user?.updatedAt ?? "", count: count)
                
                let comments = CommentViewModel(id: items.id ?? 0, typeID: items.typeID ?? 0, refID: items.refID ?? 0, content: items.content ?? "", usersID: items.usersID ?? 0, comentarioID: items.comentarioID ?? 0, createdAt: items.createdAt ?? "", updatedAt: items.updatedAt ?? "", user: user)
                
                self.modelsCommentViewModel.append(comments)
            }
        }
        
        ///UserPost View  Model
        for items in model {
            
            guard let user = items.userAuthor else {
                return
            }
            guard let count = items.userAuthor?.count else {
                return
            }
            
            guard let postimage = items.postImage else { return }
            for items in postimage {
                let image = ImageViewModel(id: items.image?.id ?? 0, src: items.image?.src ?? "", title: items.image?.title ?? "", content: items.image?.content ?? "", imageBin: items.image?.imageBin ?? "", albumID: items.image?.albumID ?? 0, usersID: items.image?.usersID ?? 0, nivelID: items.image?.nivelID ?? 0, createdAt: items.image?.createdAt ?? "", updatedAt: items.image?.updatedAt ?? "")
                
                let postimage = PostImageViewModel(postID: items.postID ?? 0, imageID: items.imageID ?? 0, createdAt: items.createdAt ?? "", updatedAt: items.updatedAt ?? "", image: image)
                
                print(postimage.imageID)
                self.modelsPostImageViewModel.append(postimage)
            }
            
            
            
            
            let userpostViewModel =
                UserpostViewModel(id            : items.id ?? 0,
                                  title         : items.title ?? "",
                                  content       : items.content ?? "",
                                  lat           : items.lat ?? 0,
                                  lng           : items.lng ?? 0,
                                  startAt       : items.startAt ?? "",
                                  finishAt      : items.finishAt ?? "",
                                  receptorTypeID: items.receptorRefID ?? 0,
                                  authorRefID   : items.authorRefID ?? 0,
                                  receptorRefID : items.receptorRefID ?? 0,
                                  posttTypeID   : items.posttTypeID ?? 0,
                                  nivelID       : items.nivelID ?? 0,
                                  createdAt     : items.createdAt ?? "",
                                  updatedAt     : items.updatedAt ?? "",
                                  idPostType    : items.idPostType ?? 0,
                                  comments      : modelsCommentViewModel, ///Array
                                  likes         : modelsLikeViewModel,    ///Array
                                  taggeds       : modelsTaggedViewModel,  ///Array
                                  userAuthor    : UserViewModel(id              : user.id ?? 0,
                                                                name            : user.name ?? "",
                                                                username        : user.username ?? "",
                                                                email           : user.email ?? "",
                                                                emailVerifiedAt : user.emailVerifiedAt ?? "",
                                                                idCount         : user.idCount ?? 0,
                                                                createdAt       : user.createdAt ?? "",
                                                                updatedAt       : user.updatedAt ?? "",
                                                                count           : CountViewModel(id         : count.id ?? 0,
                                                                                                 followers  : count.followers ?? 0,
                                                                                                 following  : count.following ?? 0,
                                                                                                 posts      : items.userAuthor?.count?.posts ?? 0,
                                                                                                 createdAt  : count.createdAt ?? "",
                                                                                                 updatedAt  : count.updatedAt ?? "")) ,
                                  postImage     : modelsPostImageViewModel , ///Array
                                  postType      : modelsPostTypeViewModel)  ///Array
            
            self.modelsUserpostViewModel.append(userpostViewModel)
        }
        
        ///Si hay arrays de objetos en models user post
        if self.modelsUserpostViewModel.count > 0 {
            completion(self.modelsUserpostViewModel)
        } else {
            print("No hay datos en modelsUserpostViewModel...")
        }
    }*/
}
