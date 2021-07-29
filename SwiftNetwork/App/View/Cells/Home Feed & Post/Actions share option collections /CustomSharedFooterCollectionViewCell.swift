//
//  CustomSharedFooterCollectionViewCell.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 19/7/21.
//

import UIKit


protocol CustomSharedFooterCollectionViewCellDelegate: AnyObject {
    func didTapCancelButton()
}
///Footer
class CustomSharedFooterCollectionViewCell:  UICollectionReusableView {
    
    static let identifier = "CustomSharedFooterCollectionViewCell"
    
    public var delegate: CustomSharedFooterCollectionViewCellDelegate?
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitle("Cancel", for: .normal)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.backgroundColor = Constants.Color.darkLigth
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
        //var border = UIView(frame: CGRectMake(0,0,self.view.bounds.width,1))
        
        
        return button
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @objc private func didTapCancelButton() {
        delegate?.didTapCancelButton()
    }

    func setupView() {
        backgroundColor = .systemBackground
        addSubview(cancelButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cancelButton.frame = CGRect(
            x: 10,
            y: 40,
            width: frame.width-20,
            height: 50)
        cancelButton.layer.cornerRadius = cancelButton.height/2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

