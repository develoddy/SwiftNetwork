//
//  ListViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit
import SkeletonView

class ListViewController: UIViewController {
    
    
    private let data: [UserRelationship]
    //private var data = [UserRelationship]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
        return table
    }()
    
    // MARK: Init
    init(data:[UserRelationship]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSkeleton()
        configureTableView()
        delegateTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func setupSkeleton() {
        //Header
        print("Eskeletonnnnnn....")
        //tableView.isSkeletonable = true
        //tableView.showSkeleton(usingColor: .blue, transition: .crossDissolve(0.25))
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .secondarySystemFill
    }
    
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}




// MARK: TableView
extension ListViewController: UITableViewDelegate, UITableViewDataSource  {
  
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell
        //cell.textLabel?.text = data[indexPath.row]
        cell.configure(with: data[indexPath.row])
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let model = data[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: UserFollowTableViewCellDelegate
extension ListViewController: UserFollowTableViewCellDelegate {
    
    func didTapFollowUnfollowButton(model: UserRelationship) {
        switch model.type {
        case .following: break
            // Perform firebase update to unfollow
        case .not_following: break
           // Perform firebase update tofollow
        }
    }
    
    
}
