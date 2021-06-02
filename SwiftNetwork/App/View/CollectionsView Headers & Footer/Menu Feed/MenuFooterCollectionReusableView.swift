//
//  MenuFooterCollectionReusableView.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 1/6/21.
//

import UIKit

class MenuFooterCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "MenuFooterCollectionReusableView"
    
    private let iconConfigurationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gearshape.fill")
        imageView.tintColor = Constants.Color.lightDark
        return imageView
    }()
    
    private let configurationAccountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    private let descriptionConfigurationsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "@Joe"
        label.textColor = .secondaryLabel
        label.backgroundColor = .systemPurple
        return label
    }()
    
    private let iconConfigurationButton: UIButton = {
        let button = UIButton()
        //button.image(for: UIImage(systemName: "chevron.down"))
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = Constants.Color.lightDark
        return button
    }()
    
    
    
    
    ///Help
    private let helpLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    ///M ode
    private let modeColorAccountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(iconConfigurationImageView)
        addSubview(configurationAccountLabel)
        addSubview(descriptionConfigurationsLabel)
        addSubview(iconConfigurationButton)
        
        
        //addSubview(helpLabel)
        //addSubview(modeColorAccountLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ///Configurations
        iconConfigurationImageView.frame = CGRect(
            x: 5,
            y: 10,
            width: 45,
            height: 45)
        iconConfigurationImageView.layer.cornerRadius = iconConfigurationImageView.height/2.0
        
        let buttonWidth = width > 500 ? 220.0 : width/5
        let labelHeight = CGFloat(20) //height/2
        
        configurationAccountLabel.frame = CGRect(
            x: iconConfigurationImageView.right+5,
            y: 10,
            width: width-8-iconConfigurationImageView.width-buttonWidth,
            height: labelHeight)
        
        descriptionConfigurationsLabel.frame = CGRect(
            x: iconConfigurationImageView.right+5,
            y: configurationAccountLabel.bottom,
            width: width-8-iconConfigurationImageView.width-buttonWidth,
            height: labelHeight
        )
        
        iconConfigurationButton.frame = CGRect(
            x: width-5-buttonWidth,
            y: 10,
            width: buttonWidth,
            height: 40
        )
        
        ///Help
        helpLabel.frame = CGRect(
            x: 5,
            y: configurationAccountLabel.bottom+5,
            width: width-10,
            height: 20)
        
        ///Mode
        modeColorAccountLabel.frame = CGRect(
            x: 5,
            y: helpLabel.bottom+5,
            width: width-10,
            height: 20)
    }
    
    override func prepareForReuse() {
        
    }
    
    
    public func configure() {
        configurationAccountLabel.text = "Configurations"
        descriptionConfigurationsLabel.text = "Configurations"
    }
}
