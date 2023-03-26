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
    
    var viewModel: PhotoPickerViewModel!
    private typealias Style = PhotoPickerStyle
        
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    private let galleryButton = UIButton()
    private let uploadButton = UIButton()
    private let cancelButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        installGalleryButton()
        installUploadButton()
        installCancelButton()
        installIndicatorView()
        setupUploadButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inject(viewModel: PhotoPickerViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    private func bind() {
        galleryButton
            .rx
            .tap
            .bind(to: viewModel.gallerySubject)
            .disposed(by: disposeBag)
        
        uploadButton
            .rx
            .tap
            .bind(to: viewModel.uploadSubject)
            .disposed(by: disposeBag)
        
        cancelButton
            .rx
            .tap
            .bind(to: viewModel.cancelSubject)
            .disposed(by: disposeBag)
        
        viewModel
            .imageDriver
            .drive(onNext: { [weak self] in
                self?.galleryButton.setImage($0, for: .normal)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .isImageSelected()
            .bind(to: uploadButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel
            .isImageSelected()
            .map { $0 ? Style.buttonColor : Style.buttonColorDisabled }
            .bind(to: uploadButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel
            .uploadRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .success:
                    self?.uploadButton.isEnabled = true
                    self?.cancelButton.isEnabled = true
                    self?.activityIndicatorView.stopAnimating()
                case .failure:
                    self?.galleryButton.setImage(UIImage(systemName: "photo.circle"), for: .normal)
                    self?.uploadButton.isEnabled = true
                    self?.cancelButton.isEnabled = true
                    self?.activityIndicatorView.stopAnimating()
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupStyle() {
        backgroundColor = Style.backgroundColor
        
        galleryButton.tintColor = Style.buttonColor
        galleryButton.layer.cornerRadius = 80
        galleryButton.clipsToBounds = true
        galleryButton.contentMode = .scaleAspectFit
        galleryButton.contentHorizontalAlignment = .fill
        galleryButton.contentVerticalAlignment = .fill
                
        uploadButton.setTitle("SAVE", for: .normal)
        uploadButton.setTitleColor(Style.backgroundColor, for: .normal)
        uploadButton.make3dButton()
        
        cancelButton.backgroundColor = Style.buttonColor
        cancelButton.setTitle("CANCEL", for: .normal)
        cancelButton.setTitleColor(Style.backgroundColor, for: .normal)
        cancelButton.make3dButton()
    }
    
    private func installGalleryButton() {
        self.addSubview(galleryButton)
        
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            galleryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            galleryButton.heightAnchor.constraint(equalToConstant: 160),
            galleryButton.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func installUploadButton() {
        self.addSubview(uploadButton)
        
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            uploadButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor,  constant: 50),
            uploadButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -50),
            uploadButton.topAnchor.constraint(equalTo: galleryButton.bottomAnchor, constant: 10),
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
    
    private func installIndicatorView() {
        self.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: uploadButton.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: uploadButton.centerXAnchor)
        ])
    }
    
    private func setupUploadButton() {
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
                            
    }
                               
                               
    @objc private func uploadButtonTapped() {
        cancelButton.isEnabled = false
        uploadButton.isEnabled = false
        uploadButton.setTitle("", for: .disabled)
        
        activityIndicatorView.startAnimating()
    }
}
