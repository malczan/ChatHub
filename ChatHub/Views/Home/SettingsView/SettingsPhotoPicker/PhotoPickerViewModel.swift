//
//  PhotoPickerViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 05/02/2023.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import Accessibility

enum PhotoPickerViewModelOutput {
    case hidePicker
    case imageUploaded
}

class PhotoPickerViewModel {
    
    enum UserInteractionType {
        case showGallery
        case hideGallery
    }
    
    let userService = ConcreteUserService()
    
    typealias Output = PhotoPickerViewModelOutput
    
    let inputImage = BehaviorRelay<UIImage>(value: UIImage(systemName: "photo.circle")!)

    private let userInteractionSubject = PublishSubject<UserInteractionType>()
    private let imageService: ImageService
    private let outputRelay: PublishRelay<Output>
    
    private let diposeBag = DisposeBag()
    
    init(outputRelay: PublishRelay<Output>,
         imageService: ImageService) {
        self.outputRelay = outputRelay
        self.imageService = imageService
    }
    
    var imageDriver: Driver<UIImage> {
        return inputImage
            .asDriver(onErrorDriveWith: Driver.never())
    }

    var userInteractionDriver: Driver<UserInteractionType> {
        userInteractionSubject
            .asDriver(onErrorDriveWith: Driver.never())
    }
    
    func galleryButtonTapped() {
        userInteractionSubject.onNext(.showGallery)
    }
    
    func uploadButtonTapped() {
        self.uploadImage()
        self.outputRelay.accept((.hidePicker))
    }
    
    func cancelButtonTapped() {
        userInteractionSubject.onNext(.hideGallery)
    }

    func isImageSelected() -> Observable<Bool> {
        return inputImage.map { $0 != UIImage(systemName: "photo.circle") }
    }
    
    func dismissPicker() {
        outputRelay.accept((.hidePicker))
    }
    
    private func uploadImage() {
        let image = inputImage.value
        imageService
            .uploadProfileImage(image)
            .subscribe { _ in
                print("@@ Refresh picture")
            } onError: { _ in
                print("@@@ ERROR")
            }
            .disposed(by: diposeBag)
    }
}
