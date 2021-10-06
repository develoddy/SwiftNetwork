//
//  CreateStoryViewController.swift
//  SwiftNetwork
//
//  Created by Eddy Donald Chinchay Lujan on 29/7/21.
//

import AVFoundation
import UIKit

class CreateStoryViewController: UIViewController {
    ///Capture session
    var session: AVCaptureSession?
    ///Photo Output
    let output = AVCapturePhotoOutput()
    ///Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    ///Layout Constrain
    var bottomConstraint: NSLayoutConstraint?
    ///Footer View
    private let footerView =  UIView()
    ///ImageStory
    private let imageStoryView = UIImageView()
    ///Preview View
    private let previewView = UIView()
    
    
    ///Shuter button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    ///Profile Photo
    private let profilePhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "eddy")
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    ///Username Label
    private let usernameLabel: UIButton = {
        let button = UIButton()
        button.setTitle("eddylujann", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        button.setImage(UIImage(systemName: "checkmark.seal.fill", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.contentHorizontalAlignment = .left
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    ///Close Button
    private let closeStoryButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    ///Footer - Profile Photo
    private let galleryButton: UIButton =  {
        let button = UIButton()
        let image = UIImage(named: "eddy")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    ///Camara reverse
    private let cameraReverse: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 37, weight: .regular)
        let image = UIImage(systemName: "arrow.triangle.2.circlepath.camera.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        return button
    }()
    
    
    ///Preview Gallery
    ///Close
    private let closePhotoGallery: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleDismissPhotoGallery), for: .touchUpInside)
        return button
    }()
    ///Footer Preview View
    private let footerPreviewView =  UIView()
    ///Download Photo
    private let savePhotoButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold)
        button.setImage(UIImage(systemName: "tray.and.arrow.down", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.setTitle("Download", for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    ///Privacity Button
    private let privacityButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold)
        button.setImage(UIImage(systemName: "exclamationmark.circle", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.setTitle("Privacy", for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    ///Friends List Button
    private let friendsListButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .semibold)
        button.setImage(UIImage(systemName: "person.2.circle", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.setTitle("Best friends", for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        setupTargets()
        setupFooterView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        previewView.frame = view.bounds
        
        previewLayer.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/1.2)
        
        //shutterButton.backgroundColor = .sys
        shutterButton.center = CGPoint(
            x: view.frame.size.width/2,
            y: view.frame.size.height-220) ///100
        
        let size = view.width/3
        profilePhotoView.frame = CGRect(
            x: 20,
            y: 40,
            width: 50,
            height: 50)
        profilePhotoView.layer.cornerRadius = profilePhotoView.height/2
        
        let usernameLabelSize = usernameLabel.sizeThatFits(view.frame.size)
        usernameLabel.frame = CGRect(
                x: profilePhotoView.right+15,
                y: 40,
                width: view.width-(size),
            height: usernameLabelSize.height).integral
        usernameLabel.backgroundColor = .clear
        
        closeStoryButton.frame = CGRect(
            x: usernameLabel.right+5,
            y: 40,
            width:size/3,
            height:50)
        closeStoryButton.backgroundColor = .clear
        
        ///Preview View Gallery
        imageStoryView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/1.2)
        previewView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/1.2)
        closePhotoGallery.frame = CGRect(
            x: 20,
            y: 40,
            width: 50,
            height: 50)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func setup() {
        view.backgroundColor = .black
        previewLayer.backgroundColor = UIColor.systemRed.cgColor
        checkCameraPermissions()
    }
    
    private func setupView() {
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        view.addSubview(profilePhotoView)
        view.addSubview(usernameLabel)
        view.addSubview(closeStoryButton)
    }
    
    private func setupShowPhotoGallery() {
        previewView.backgroundColor = .systemYellow
        previewView.clipsToBounds = true
        previewView.contentMode = .scaleAspectFill
        previewView.layer.cornerRadius = 22
        previewView.layer.borderWidth = 2
        view.addSubview(previewView)
        
        imageStoryView.frame = view.bounds
        imageStoryView.clipsToBounds = true
        imageStoryView.contentMode = .scaleAspectFill
        
        previewView.addSubview(imageStoryView)
        previewView.addSubview(closePhotoGallery)
    }
    
    private func setupTargets() {
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(didTapOpenGallery), for: .touchUpInside)
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            ///Request
            AVCaptureDevice.requestAccess(for: .video) { [ weak self ] granted  in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
            
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                previewLayer.cornerRadius = 22
                previewLayer.borderWidth = 0
                
                
                session.startRunning()
                self.session = session
            } catch {
                print(error)
            }
        }
    }
    
    
    private func setupFooterView() {
        view.addSubview(footerView)
        view.addConstraintWhithFormat(format:"H:|[v0]|",views: footerView)
        view.addConstraintWhithFormat(format:"V:[v0(125)]",views: footerView)
        
        bottomConstraint = NSLayoutConstraint(
            item: footerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: -0)
        view.addConstraint(bottomConstraint!)
        setupFooterViewComponents()
    }
    
    private func setupFooterPreview() {
        view.addSubview(footerPreviewView)
        view.addConstraintWhithFormat(format:"H:|[v0]|",views: footerPreviewView)
        view.addConstraintWhithFormat(format:"V:[v0(125)]",views: footerPreviewView)
        
        bottomConstraint = NSLayoutConstraint(
            item: footerPreviewView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: -0)
        view.addConstraint(bottomConstraint!)
        setupFooterPreviewComponents()
    }
    
    private func  setupFooterPreviewComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        footerPreviewView.backgroundColor = .red
        
        footerPreviewView.addSubview(savePhotoButton)
        footerPreviewView.addSubview(privacityButton)
        footerPreviewView.addSubview(friendsListButton)
        
        ///savePhotoButton, privacityButton
        let buttonSize = footerView.height-10
        let buttons = [savePhotoButton, privacityButton, friendsListButton]
    
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.contentHorizontalAlignment = .left
            button.frame = CGRect(
                x: (CGFloat(x)*buttonSize)+(10*CGFloat(x+1)),
                y: 5,
                width: buttonSize,
                height: 40)
        }
    }
    
    private func  setupFooterViewComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        footerView.backgroundColor = .black
        
        let size = footerView.height-38
        
        footerView.addSubview(galleryButton)
        galleryButton.frame = CGRect(
            x: 15,
            y: 15,
            width: 35,
            height: 40)
        
        footerView.addSubview(cameraReverse)
        cameraReverse.frame = CGRect(
            x: view.width-size-38, //view.frame.size.width-cameraReverse.frame.size.width - 15
            y: 15,
            width: size,
            height: 40)
    }
    
    @objc func didTapOpenGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.modalTransitionStyle = .crossDissolve
        imagePickerController.modalPresentationStyle = .fullScreen
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @objc func didTapTakePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDismissPhotoGallery() {
        imageStoryView.image = nil
        setupView()
        didTapOpenGallery()
    }
    
    
}

extension CreateStoryViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        let image = UIImage(data: data)
        
        session?.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
    }
}


extension CreateStoryViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[ .editedImage ] as? UIImage {
            imageStoryView.image = image
            setupShowPhotoGallery()
            setupFooterPreview()
        } else  if let image = info[ .originalImage ] as? UIImage {
            imageStoryView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("close photo gallery")
        picker.dismiss(animated: true, completion: nil)
        
    }
}
