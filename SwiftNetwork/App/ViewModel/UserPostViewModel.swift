//
//  UserPostViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 4/12/21.
//

import Foundation
import CoreData

//MARK: UserPostViewModel
class UserPostViewModel {

    private var apiService = APIService()
    
    static let database = DatabaseHandler.shared
    
    //var models = [Userpost]()
    var models = [CD0011_posts]()
    
    public var user: User?
    
    public var story = [Storyfeatured]()
    
<<<<<<< HEAD
    
    //MARK: Profile
    func apiProfile(email: String, token: String, completion : @escaping ((Result<UserPost, Error>)) -> ()) {
        BCApiRest.profile(email, token) { ( object ) in
            completion(.success(object))
        } conCompletionIncorrecto: { (messageError) in
            completion(.failure(messageError as! Error))
        }
    }
    func fetchUserPostData(author_ref_id: Int, email: String, completion : @escaping ((Result<[CD0011_posts], Error>)) -> ()) {
        self.models = HomeViewModel.database.fetchUserPost(CD0011_posts.self, author_ref_id: author_ref_id, email: email)
        if self.models.count > 0 {
            completion(.success(self.models))
        } else {
            print("fetchUserPostData: error.localizedDescription")
        }
=======
    ///Api Rest.
    ///En esta función llamamos al Api rest para traes los datos de la DataBase,
    ///Desde handleNotAuthenticated ontenemos tanto el token como el email del usario que está conectado a la App.
    func fetchUserpostData(email: String,token: String, completion: @escaping () -> ()) {
        /*APIService.shared.getProfile(email: email, token: token ) {(result) in
            switch result {
            case .success(let model):
                for items in model.userpost ?? [] {
                    let userpost = Userpost(id: items.id, title: items.title, content: items.content, lat: items.lat, lng: items.lng, startAt: items.startAt, finishAt: items.finishAt, receptorTypeID: items.receptorRefID, authorRefID: items.authorRefID, receptorRefID: items.receptorRefID, posttTypeID: items.posttTypeID, nivelID: items.nivelID, createdAt: items.createdAt, updatedAt: items.updatedAt, idPostType: items.idPostType, comments: items.comments, likes: items.likes, taggeds: items.taggeds, userAuthor: items.userAuthor, postImage: items.postImage, postType: items.postType )
                    self.models.append(userpost)

                    guard let user = items.userAuthor, let story = items.userAuthor?.profile?.storyfeatured else { return }
                    self.user = user
                    self.story.append(contentsOf: story)
                }
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }*/
>>>>>>> recover-branch
    }
    
    func numberOfSections() -> Int {
        return 3
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if models.count != 0 {
            return models.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CD0011_posts {
        return models[indexPath.row]
        //return CD0011_posts()
    }
    
    
    func fetchPostImageData(post: CD0011_posts) -> [CD0010_images]  {
        var arrayImage = [CD0010_images]()
        let entityPostImage = HomeViewModel.database.fetch(CD0012_post_images.self)
        for itemPostImage in entityPostImage {
            if itemPostImage.cd12_post_id == post.id {
                let entityImage = HomeViewModel.database.fetch(CD0010_images.self)
                for itemImage in entityImage {
                    if itemPostImage.cd12_image_id == itemImage.cd10_id  {
                        arrayImage.append(itemImage)
                    }
                }
            }
        }
        return arrayImage
    }
    
    
    func getAllUserpostData() -> [CD0011_posts] {
        //return models
        return []
    }
    
}
