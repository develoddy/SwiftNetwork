//
//  ProfileViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 10/1/22.
//

import Foundation

//MARK: VIEWMODEL -> API SERVICE
class ProfileViewModel {
    
    private var apiService = APIService()
    
    public var models = [ Userpost ]()
    
    private var user: User?
    
    // MARK: Fetch Profile Data.
    func fetchProfileData( email: String,
                           token: String,
                           completion: @escaping () -> () ) {
        
        apiService.getProfile( email: email, token: token ) { [ weak self ] ( result ) in
            switch result {
            case .success( let listOf ):
                guard let userpost = listOf.userpost else {
                    return
                }
                self?.models = userpost
                completion()
            case .failure(let error):
                print("Error processing data \(error)")
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
    func cellForRowAt(indexPath: IndexPath) -> Userpost {
        return models[ indexPath.row ]
    }
    
    // Fetch username.
    func fetchUsername(indexPath: IndexPath) -> User? {
        let user = models[ indexPath.row ].userAuthor
        return user
    }
}
