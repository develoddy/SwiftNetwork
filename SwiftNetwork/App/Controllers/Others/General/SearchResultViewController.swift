//
//  SearchResultViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

enum SearchResult {
    case artist(model: String)
    case album(model: String)
    case track(model: String)
    case playlist(model: String)
}


class SearchResultViewController: UIViewController {
    
    static weak var shared: SearchResultViewController?
    
    private var models = [Userpost]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.isHidden = true
        return tableView
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    
    public func getUserToken() -> ResponseTokenBE? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let token = appDelegate.objUsuarioSesion else {
            return getUserToken()
        }
        return token
    }
    
    private func configureTableView() {
        tableView.register(SearchResultViewTableViewCell.self, forCellReuseIdentifier: SearchResultViewTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    ///Update
    func update(with results: [Userpost]) {
        self.models = results
        tableView.reloadData()
        tableView.isHidden = models.isEmpty
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewTableViewCell.identifier, for: indexPath) as! SearchResultViewTableViewCell
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        /**let model = models[indexPath.row]
        let vc =  PruebaViewController(with: model.userAuthor?.email ?? "")///PostViewController(model: model)
        vc.title = "Posts"
        vc.navigationItem.largeTitleDisplayMode = .never
        presentingViewController?.navigationController?.pushViewController(vc, animated: true)*/
        let model = models[indexPath.row]
        guard let email = model.userAuthor?.email,
              let name = model.userAuthor?.name else {
            return
        }
        //let vc = UserPostViewController(email: email, token: getUserToken()?.token ?? "")
        //vc.title = name
        //presentingViewController?.navigationController?.pushViewController(vc, animated: true)
        
    }
}
