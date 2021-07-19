//
//  BaseViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 9/7/21.
//

import UIKit

class BaseViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
