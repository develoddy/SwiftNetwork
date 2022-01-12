//
//  ProfileReusableViewProtocol.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 11/1/22.
//

import Foundation

//MARK: Protocol
protocol ProfileReusableViewProtocol {
    func didTapPostButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func didTapFollowersButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func didTapFollowingButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func didTapEditProfileButton( _header:  ProfileInfoHeaderCollectionReusableView)
    func didTapEditProfileButton( _post:  ProfileInfoHeaderCollectionReusableView)
}
