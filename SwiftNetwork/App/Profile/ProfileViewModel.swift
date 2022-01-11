//
//  ProfileViewModel.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 10/1/22.
//

import Foundation

//MARK: VIEWMODEL -> API SERVICE
class ProfileViewModel {
    
    // MARK: - Closures
    // Through these closures, our view model will execute code while some events will occure
    // They will be set up by the view controller
    
    var reloadTableViewClosure      : (()->())?
    var showAlertClosure            : (()->())?
    var updateLoadingStatusClosure  : (()->())?
    
    // MARK: - Properties
        
    // We defined the FakeAPIServiceProtocol in the APIService.swift file.
    // We also defined a class and make it conform to that protocol.
    let apiService: APIServiceProtocol
    
    // This will contain info about the picture eventually selectded by the user by tapping an item on the screen
    var selectedPicture: Userpost?
    
    // The collection that will contain our fetched data
    private var userpost: [Userpost] = [Userpost]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    // A property containing the number ot items, it will be used by the view controller to render items on the screen using a
    var numberOfItems: Int {
        return userpost.count
    }
    
    // The collection that will contain our fetched data
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }
    
    // MARK: - Constructor
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    
    // MARK: - Fetching functions
    func fetchData( email: String, token: String ) {
        self.isLoading = true
        apiService.getProfile(email: email, token: token) { [ weak self ] ( result ) in
            switch result {
            case .success( let listOf ):
                guard let userpost = listOf.userpost else {
                    return
                }
                self?.userpost = userpost
            case .failure(let error):
                print("Error processing data \(error)")
            }
            self?.isLoading = false
        }
    }
    
    
    // MARK: - Retieve Data
    
    // Number of sections
    func numberOfSections() -> Int {
        return 3
    }
    
    // Number of row in section
    func numberOfRowsInSection(section: Int) -> Int {
        if userpost.count != 0 {
            return userpost.count
        }
        return 0
    }
    
    // Model IndexPath row
    func cellForRowAt(indexPath: IndexPath) -> Userpost {
        return userpost[indexPath.row]
    }
    
    // Fetch username
    func fetchUsername(indexPath: IndexPath) -> User? {
        let user = userpost[indexPath.row].userAuthor
        return user
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*private var apiService = APIService()
    
    public var models = [ Userpost ]()
    
    private var user: User?
    
    
    // MARK: Fetch Profile Data.
    func fetchProfileData( email: String, token: String, completion: @escaping () -> () ) {
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
        return 3
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
        return models[indexPath.row]
    }
    
    // Fetch username.
    func fetchUsername(indexPath: IndexPath) -> User? {
        let user = models[indexPath.row].userAuthor
        return user
    }*/
}
