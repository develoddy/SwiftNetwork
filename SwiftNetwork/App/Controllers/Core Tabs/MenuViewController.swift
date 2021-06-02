//
//  MenuViewController.swift
//  
//
//  Created by Eddy Donald Chinchay Lujan on 15/5/21.
//

import UIKit

struct MenuCellModel {
    let tile: String
    let handler: ( () -> Void )
}


struct MenuCollectionViewModel {
    let image: UIImage?
    let title: String?
    let color: UIColor?
}


extension MenuViewController {
    func setupModel()  {
        let menuCollectionViewModel1 = MenuCollectionViewModel(image: UIImage(systemName: "person.2.fill"), title: "Friends", color: .systemBlue)
        let menuCollectionViewModel2 = MenuCollectionViewModel(image: UIImage(systemName: "photo.on.rectangle.angled"), title: "Photos", color: .systemYellow)
        let menuCollectionViewModel3 = MenuCollectionViewModel(image: UIImage(systemName: "bookmark.fill"), title: "Bookmark", color: .systemRed)
        let menuCollectionViewModel4 = MenuCollectionViewModel(image: UIImage(systemName: "gamecontroller.fill"), title: "Play", color: .systemPink)
        let menuCollectionViewModel5 = MenuCollectionViewModel(image: UIImage(systemName: "clock"), title: "Regards", color: .systemTeal)
        let menuCollectionViewModel6 = MenuCollectionViewModel(image: UIImage(systemName: "person.3.fill"), title: "Groups", color: .systemGreen)
        let menuCollectionViewModel7 = MenuCollectionViewModel(image: UIImage(systemName: "paperplane.circle.fill"), title: "Chat", color: .systemPurple)
        let menuCollectionViewModel8 = MenuCollectionViewModel(image: UIImage(systemName: "magnifyingglass"), title: "Search Friend", color: .darkGray)
        let menuCollectionViewModel9 = MenuCollectionViewModel(image: UIImage(systemName: "calendar.badge.clock"), title: "Events", color: .systemYellow)
        let menuCollectionViewModel10 = MenuCollectionViewModel(image:UIImage(systemName: "antenna.radiowaves.left.and.right"), title: "Friends around", color: .systemTeal)
        
        menuCollectionViewModel.append(menuCollectionViewModel1)
        menuCollectionViewModel.append(menuCollectionViewModel2)
        menuCollectionViewModel.append(menuCollectionViewModel3)
        menuCollectionViewModel.append(menuCollectionViewModel4)
        menuCollectionViewModel.append(menuCollectionViewModel5)
        menuCollectionViewModel.append(menuCollectionViewModel6)
        menuCollectionViewModel.append(menuCollectionViewModel7)
        menuCollectionViewModel.append(menuCollectionViewModel8)
        menuCollectionViewModel.append(menuCollectionViewModel9)
        menuCollectionViewModel.append(menuCollectionViewModel10)
    }
}


class MenuViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private var data = [ [ MenuCellModel ] ]()
    
    private var menuCollectionViewModel = [ MenuCollectionViewModel ]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCollectionView()
        delegateCollectionView()
        setupLeftNavItems()
        setupRightNavItems()
        configureModels()
        setupModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    ///Configure collections
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 1.5, left: 2, bottom: 1.5, right: 1.5)
        
        let size = (view.width-4)/2
        layout.itemSize = CGSize(width: size-5, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = Constants.Color.whiteLight
        collectionView?.showsVerticalScrollIndicator = false
        
        
        ///Header collections
        collectionView?.register(
            MenuHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MenuHeaderCollectionReusableView.identifier)
        
        ///Grid collectionsView boddy
        collectionView?.register(
            MenuCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        
        ///Footer collections
        collectionView?.register(
            MenuFooterCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: MenuFooterCollectionReusableView.identifier)
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    private func delegateCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    private func configureModels() {
        data.append([
            MenuCellModel(tile: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            MenuCellModel(tile: "Invite Fiends") { [weak self] in
                self?.didTapInviteFriends()
            },
            MenuCellModel(tile: "Save original Posts") { [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        
        
        data.append([
            MenuCellModel(tile: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    ///Taps
    private func didTapEditProfile() {}
    private func didTapInviteFriends() {}
    private func didTapSaveOriginalPosts() {}
    private func didTapLogOut() {}
}

//MARK: - UITableView
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /*private func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }*/
    
    ///Count the models
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /*if section == 1 {
            return data[section].count
        }*/
        return menuCollectionViewModel.count
    }
    
    ///CollectionViewCell the MenuCollectionViewCell grid
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = menuCollectionViewModel[indexPath.row]
        print(model)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        cell.configure(model: model)
        return cell
    }
    
    ///CollectionReusableView the header and footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MenuFooterCollectionReusableView.identifier,
                for: indexPath) as! MenuFooterCollectionReusableView
            footer.configure()
            return footer
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: MenuHeaderCollectionReusableView.identifier,
            for: indexPath) as! MenuHeaderCollectionReusableView
        return header
    }
    
    ///Width and Height the header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: 80)
    }
    
    ///Width and Height the footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height/3)
    }
    
    ///Selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // get the model and open post controller
        print("xxxx")
    }
}

//MARK: - Buttons Left y rigth
extension MenuViewController {
    private func setupLeftNavItems() {
        let followButton = UIButton(type: .system)
        followButton.setTitle("MENU", for: .normal)
        followButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .black )
        followButton.tintColor = Constants.Color.purple
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func  setupRightNavItems() {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor =  Constants.Color.purple
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let composeButton = UIButton(type: .system)
        composeButton.setImage(UIImage(systemName: "plus"), for: .normal)
        composeButton.tintColor = Constants.Color.purple
        composeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: searchButton),
            UIBarButtonItem(customView: composeButton)
        ]
    }
}
