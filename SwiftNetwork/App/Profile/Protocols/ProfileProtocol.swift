//
//  ProfileProtocol.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 11/1/22.
//

import Foundation
import UIKit

//MARK: Protocol
protocol ProfileProtocol {
    func retrieveNumberOfSections() -> Int
    func retrieveNumberOfRowsInSection(section: Int) -> Int
    func getData(indexPath: IndexPath) -> Userpost
    func retrieveSizeForItemAt() -> CGSize
    func retrieveInsetForSectionAt() -> UIEdgeInsets
    func getUserData(indexPath: IndexPath) -> User?
    func itemSelected(indexPath: IndexPath)
    
}
