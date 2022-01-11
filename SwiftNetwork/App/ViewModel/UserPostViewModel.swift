//
//  UserPostViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 4/12/21.
//

import Foundation


//MARK: UserPostViewModel
class UserPostViewModel {

    private var apiService = APIService()
    
    var models = [Userpost]()
    
    public var user: User?
    
    public var story = [Storyfeatured]()
    
    ///Api Rest.
    ///En esta función llamamos al Api rest para traes los datos de la DataBase,
    ///Desde handleNotAuthenticated ontenemos tanto el token como el email del usario que está conectado a la App.
    func fetchUserpostData(email: String,token: String, completion: @escaping () -> ()) {
        APIService.shared.getProfile(email: email, token: token ) {(result) in
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
        }
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
    
    func cellForRowAt(indexPath: IndexPath) -> Userpost {
        return models[indexPath.row]
    }
    
}
