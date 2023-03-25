//
//  PhotoPickerView+Factory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 05/02/2023.
//

import Foundation


enum PhotoPickerViewControllerFactory {

    static func createPhotoPickerViewController(viewModel: PhotoPickerViewModel) -> PhotoPickerViewController {
        let photoPickerViewController = PhotoPickerViewController()
        photoPickerViewController.viewModel = viewModel
        return photoPickerViewController
    }
}
