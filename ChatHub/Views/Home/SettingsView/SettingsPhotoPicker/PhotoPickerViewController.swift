//
//  PhotoPickerViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import Photos
import PhotosUI
import UIKit
import RxCocoa
import RxSwift

class PhotoPickerViewController: UIViewController, PHPickerViewControllerDelegate {
    
    var viewModel: PhotoPickerViewModel!
    
    private var bottomAnchor: NSLayoutConstraint?
    private var photoPickerView: PhotoPickerView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPickerWithAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        installPopUpView()
        
        viewModel
            .userInteractionDriver
            .drive(onNext: { [weak self] in
                switch $0 {
                case .showGallery:
                    self?.showSystemPhotoPicker()
                case .hideGallery:
                    self?.hidePopUpWithAnimation()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupStyle() {
        view.backgroundColor = .clear
    }
    
    private func installPopUpView() {
        photoPickerView = PhotoPickerView()
        photoPickerView.inject(viewModel: viewModel)
        
        view.addSubview(photoPickerView)
        
        photoPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomAnchor = photoPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300)
        bottomAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            photoPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoPickerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func hidePopUpWithAnimation() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut) {
            self.bottomAnchor?.constant = 300
            self.view.backgroundColor = .clear
            self.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.viewModel?.dismissPicker()
        }
    }
    
    private func showPickerWithAnimation() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseIn) {
            self.bottomAnchor?.constant = 0
            self.view.backgroundColor = .black.withAlphaComponent(0.4)
            self.view.layoutIfNeeded()
        }
    }
    
    private func showSystemPhotoPicker() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        let photoPickerViewController = PHPickerViewController(configuration: config)
        photoPickerViewController.delegate = self
        present(photoPickerViewController, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                self?.viewModel.inputImage.accept(image)
            }
        }
    }
}

