//
//  UserpostViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 1/12/21.
//

import Foundation

//MARK: - UserpostViewModel
class UserpostViewModel {
    
    private var apiService = APIService()
    
    public var models = [HomeFeedRenderViewModel]()
    
    func fetchUserPostData(token: String, completion: @escaping () -> ()) {
        apiService.apiUserPost(token: token) {(result) in
            switch result {
            case .success(let model):
                for items in model.userpost ?? [] {
                    guard let user = items.userAuthor else { return }
                    guard let comments = items.comments else { return }
                    let viewModel = HomeFeedRenderViewModel(
                        header      : PostRenderViewModel(renderType: .header(provider: user)),
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


//MARK: - UserpostViewModel
class LikeViewModel {
    
    private var apiService = APIService()

    func liked(ref_id: Int, users_id: Int, token: String, completion: @escaping ((Result<Bool, Error>)) -> ()) {
        APIService.shared.apiLiked(ref_id: ref_id, users_id: users_id, token: token ) {( result ) in
            switch result {
            case .success(let message):
                let liked = message.store == "true" ? true : false
                completion(.success(liked))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
