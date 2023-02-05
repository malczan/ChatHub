//
//  PhotoPickerViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

class PhotoPickerViewController: UIViewController {
    
    private var bottomAnchor: NSLayoutConstraint?
    private var photoPickerView: PhotoPickerView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPickerWithAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        installPopUpView()
    }
    
    private func setupStyle() {
        view.backgroundColor = .clear
    }
    
    private func installPopUpView() {
        photoPickerView = PhotoPickerView()
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
            //
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
    
}

