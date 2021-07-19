//
//  StorieViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 16/7/21.
//

import UIKit

class StoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        configureBarButton()
    }
    
    func setupView() {
        view.backgroundColor = .systemOrange
    }
    
    private func configureBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    // MARK: Action
    @objc func didTapSave() {
        // Save info to database
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }



}
