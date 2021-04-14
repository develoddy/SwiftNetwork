//
//  IGFeedPostActionsTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 14/4/21.
//

import UIKit

class IGFeedPostActionsTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostActionsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // Configure the cell
    }
}
