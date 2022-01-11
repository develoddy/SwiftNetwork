//
//  UserpostViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 1/12/21.
//

import Foundation

//MARK: VIEWMODEL -> API SERVICE
class HomeViewModel {
    
    private var apiService = APIService()
    
    public var models = [ HomeFeedRenderViewModel ]()
    
    // MARK: Fetch User Post.
    func fetchUserpostData( token: String,
                            completion: @escaping () -> ()) {
        
        apiService.getUserPost( token: token ) { [ weak self ] ( result ) in
            switch result {
            // SUCCESS
            case .success( let listOf ):
                guard let userposts = listOf.userpost else { return }
                for items in userposts {
                    guard let comments = items.comments else { return }
                    let viewModel = HomeFeedRenderViewModel(
                        header      : PostRenderViewModel(renderType: .header(provider: items)),
                        post        : PostRenderViewModel(renderType: .primaryContent(provider: items)),
                        actions     : PostRenderViewModel(renderType: .actions(provider: items)),
                        descriptions: PostRenderViewModel(renderType: .descriptions(post: items)),
                        comments    : PostRenderViewModel(renderType: .comments(comments: comments)),
                        footer      : PostRenderViewModel(renderType: .footer(footer: items)))
                    self?.models.append( viewModel )
                }
                completion()
            
            // FAIULURE
            case .failure(let error):
            print(error.localizedDescription)
            print("Error processing json data: \(error)")
            }
        }
    }
    
    // Number of sections.
    func numberOfSections() -> Int {
        return models.count
    }
    
    // Number of row in section.
    func numberOfRowsInSection(section: Int) -> Int {
        if models.count != 0 {
            return models.count
        }
        return 0
    }
    
    // Model IndexPath row.
    func cellForRowAt(indexPath: IndexPath) -> HomeFeedRenderViewModel {
        return models[ indexPath.row ]
    }
}
