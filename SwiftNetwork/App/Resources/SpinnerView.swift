//
//  SpinnerView.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 25/10/21.
//

import UIKit


//MARK: CustomLoader
class CustomLoader: UIView {
    
    static let instance = CustomLoader()
    
    var viewColor: UIColor = UIColor.black
    var setAlpha: CGFloat = 0.5
    var gifName: String = ""
    
    lazy var transparentView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = viewColor 
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var gifImage: UIImageView = {
        let gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.sd_setImage(with: URL(string: gifName), completed: nil)
        return gifImage
    }()
    
    func showLoader() {
        self.addSubview(transparentView)
        self.transparentView.addSubview(gifImage)
        self.transparentView.bringSubviewToFront(self.gifImage)
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        keyWindow?.addSubview(transparentView)
    }
    
    func hideLoader() {
        self.transparentView.removeFromSuperview()
    }
}


//MARK: SpinnerView
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
