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
    
    //private var results: [SearchResult] = []
    private var results: [Search] = []
    
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
    
    private func configureTableView() {
        tableView.register(SearchResultViewTableViewCell.self, forCellReuseIdentifier: SearchResultViewTableViewCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func delegateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    ///Receive data from the SearchViewController
    func update(with results: [Search]) {
        self.results = results
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultViewTableViewCell.identifier, for: indexPath) as! SearchResultViewTableViewCell
        cell.configure(with: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Did select normal list item")
    }
}
