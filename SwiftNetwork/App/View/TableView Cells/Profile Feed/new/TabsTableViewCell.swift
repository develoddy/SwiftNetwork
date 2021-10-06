//
//  TabsTableViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 6/10/21.
//

import UIKit

//MARK: Tabs
class TabsTableViewCell:  UITableViewCell {
    
    static let identifier = "TabsTableViewCell"
    
    private let gridButton: UIButton = {
        let button  = UIButton()
        button.clipsToBounds = true
        button.tintColor = .black
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button  = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemYellow
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(gridButton)
        addSubview(taggedButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size =  height - (Constants.ProfileTabsCollectionReusableViewColor.padding * 2)
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(
            x: gridButtonX,
            y: Constants.ProfileTabsCollectionReusableViewColor.padding,
            width: size,
            height: size)
        taggedButton.frame = CGRect(
            x: gridButtonX + (width/2),
            y: Constants.ProfileTabsCollectionReusableViewColor.padding,
            width: size,
            height: size)
    }
}
