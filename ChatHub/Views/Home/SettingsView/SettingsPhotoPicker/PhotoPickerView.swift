//
//  PhotoPickerView.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit
import RxCocoa
import RxSwift

class PhotoPickerView: UIView {
    
    private typealias Style = PhotoPickerStyle
        
    private let galleryButton = UIButton()
    private let messageLabel = UILabel()
    private let uploadButton = UIButton()
    private let cancelButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        installGalleryButton()
        installMessageLabel()
        installUploadButton()
        installCancelButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        backgroundColor = Style.backgroundColor
        
        galleryButton.setImage(Style.galleryImage, for: .normal)
        galleryButton.tintColor = Style.buttonColor
        galleryButton.layer.cornerRadius = 60
        galleryButton.imageView?.contentMode = .scaleAspectFit
        galleryButton.contentMode = .scaleAspectFit
        galleryButton.contentHorizontalAlignment = .fill
        galleryButton.contentVerticalAlignment = .fill
                
        messageLabel.text = "Select photo first!"
        messageLabel.textColor = Style.errorColor
        messageLabel.isHidden = false
        
        uploadButton.backgroundColor = Style.buttonColor
        uploadButton.setTitle("UPLOAD", for: .normal)
        uploadButton.setTitleColor(Style.buttonColor, for: .normal)
        uploadButton.make3dButton()
        
        cancelButton.backgroundColor = Style.buttonColor
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.setTitleColor(Style.buttonColor, for: .normal)
        cancelButton.make3dButton()
    
    }
    
    private func installGalleryButton() {
        self.addSubview(galleryButton)
        
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            galleryButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            galleryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            galleryButton.heightAnchor.constraint(equalToConstant: 120),
            galleryButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func installMessageLabel() {
        self.addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func installUploadButton() {
        self.addSubview(uploadButton)
        
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor,  constant: 50),
            uploadButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -50),
            uploadButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15),
            uploadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installCancelButton() {
        self.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor,  constant: 50),
            cancelButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -50),
            cancelButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            cancelButton.topAnchor.constraint(equalTo: uploadButton.bottomAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
