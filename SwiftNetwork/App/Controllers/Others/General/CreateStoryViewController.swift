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
    ///Shuter button
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.layer.cornerRadius = 50
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        setupTargets()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        shutterButton.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height-100)
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
    }
    
    private func setupTargets() {
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
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
                
                session.startRunning()
                self.session = session
            } catch {
                print(error)
            }
        }
    }
    
    @objc func didTapTakePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
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
        view.addSubview(imageView)
    }
}













/*class CreateStoryViewController: UIViewController {
        
    private let imageStoryView = UIImageView()
    
    private let closeStoryButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
        button.setImage(UIImage(systemName: "xmark", withConfiguration: config)?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        imageStoryView.frame = view.bounds
        imageStoryView.contentMode = .scaleAspectFill
        view.addSubview(imageStoryView)
    }
    
    private func setup() {
        openGallery()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(closeStoryButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeStoryButton.frame = CGRect(
            x: 10,
            y: 30,
            width:50,
            height:50)
        closeStoryButton.layer.cornerRadius = closeStoryButton.height/2
        closeStoryButton.backgroundColor = .systemYellow
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateStoryViewController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[ .editedImage ] as? UIImage {
            imageStoryView.image = image
            setupView()
        } else  if let image = info[ .originalImage ] as? UIImage {
            imageStoryView.image = image
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}*/
