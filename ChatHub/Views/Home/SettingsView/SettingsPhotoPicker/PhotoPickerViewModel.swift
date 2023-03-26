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
    
    let userService = ConcreteUserService()
    
    typealias Output = PhotoPickerViewModelOutput
    
    let inputImage = BehaviorRelay<UIImage>(value: UIImage(systemName: "photo.circle")!)
    let gallerySubject = PublishSubject<Void>()
    let uploadSubject = PublishSubject<Void>()
    let cancelSubject = PublishSubject<Void>()

    let uploadRelay = PublishRelay<Result<Void, Error>>()
    private let imageService: ImageService
    private let outputRelay: PublishRelay<Output>
    
    private let diposeBag = DisposeBag()
    
    init(outputRelay: PublishRelay<Output>,
         imageService: ImageService) {
        self.outputRelay = outputRelay
        self.imageService = imageService
        bind()
    }
    
    var imageDriver: Driver<UIImage> {
        return inputImage.asObservable().asDriver(onErrorJustReturn: UIImage(systemName: "photo.circle")!)
        
    }
        
    var cancelDriver: Driver<Void> {
        return cancelSubject.asDriver(onErrorJustReturn: ())
    }
    
    func isImageSelected() -> Observable<Bool> {
        return inputImage.map { $0 != UIImage(systemName: "photo.circle") }
    }
    
    func cancelTapped() {
        outputRelay.accept((.hidePicker))
    }
    
    private func bind() {
        uploadSubject
            .subscribe(onNext: { [weak self] in
                self?.uploadImage()
            })
            .disposed(by: diposeBag)
    }
    
    private func uploadImage() {
        let image = inputImage.value
        imageService
            .uploadProfileImage(image)
            .subscribe { [weak self] _ in
                self?.uploadRelay.accept(.success(()))
                self?.userService.refreshUserInfo()
                self?.outputRelay.accept(.hidePicker)
            } onError: { [weak self] in
                self?.uploadRelay.accept(.failure($0))
            }
            .disposed(by: diposeBag)

                      
    }
}
