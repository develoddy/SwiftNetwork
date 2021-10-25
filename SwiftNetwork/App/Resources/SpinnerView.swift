//
//  SpinnerView.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 25/10/21.
//

import UIKit

class SpinnerView: NSObject {
    
    static let shared = SpinnerView()
    
    var spinner = UIActivityIndicatorView()
    
    var VW_overlay: UIView = UIView()
    
    public func setupSpinner() -> UIActivityIndicatorView {
        spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.color = Constants.Color.general
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }
    
    
}
