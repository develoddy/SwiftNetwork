//
//  PublishPostViewController.swift
//  Blubinn
//
//  Created by Eddy Donald Chinchay Lujan on 31/3/21.
//

import UIKit

class PublishPostViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureBarButton()
    }
    
    private func setupView() {
        view.backgroundColor = .systemRed
    }
    
    private func configureBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(didTapPost))
        
    }
    
    // MARK: Action

    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapPost() {
        // Save info to database
        dismiss(animated: true, completion: nil)
    }
}
