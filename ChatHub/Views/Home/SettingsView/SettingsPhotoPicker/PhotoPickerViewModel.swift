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

    private let imageService = ConcreteImageService()
    private let outputRelay: PublishRelay<Output>
    
    private let diposeBag = DisposeBag()
    
    init(outputRelay: PublishRelay<Output>) {
        self.outputRelay = outputRelay
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
                self?.outputRelay.accept((.hidePicker))
                
            })
            .disposed(by: diposeBag)
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
