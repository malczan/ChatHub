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

class PhotoPickerViewModel {
    
    let inputImage = BehaviorRelay<UIImage>(value: UIImage(systemName: "photo.circle")!)
    let gallerySubject = PublishSubject<Void>()
    let uploadSubject = PublishSubject<Void>()
    let cancelSubject = PublishSubject<Void>()
    
    private let outputRelay: PublishRelay<Void>
    
    private let diposeBag = DisposeBag()
    
    init(outputRelay: PublishRelay<Void>) {
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
        outputRelay.accept(())
    }
    
    private func bind() {
        uploadSubject
            .subscribe(onNext: { [weak self] in
                print("@@@@")
            })
            .disposed(by: diposeBag)
    }
}
