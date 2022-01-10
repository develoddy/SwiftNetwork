//
//  UserpostViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 1/12/21.
//

import Foundation

//MARK: - UserpostViewModel
//class UserpostViewModel {
class HomeViewModel {
    
    private var apiService = APIService()
    
    public var models = [HomeFeedRenderViewModel]()
    
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
