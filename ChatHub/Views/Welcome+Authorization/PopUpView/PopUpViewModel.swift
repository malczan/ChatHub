//
//  PopUpViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/02/2023.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay


class PopUpViewModel {
    
    let labelText: String
    private let hideSubject = PublishSubject<Void>()
    
    private let outputRelay: PublishRelay<Void>
    
    init(error: Error,
         outputRelay: PublishRelay<Void>) {
        self.labelText = error.localizedDescription
        self.outputRelay = outputRelay
    }
    
    var hideDriver: Driver<Void> {
        return hideSubject
            .asDriver(onErrorDriveWith: Driver.never())
    }
    
    func buttonTapped() {
        hideSubject.onNext(())
    }
    
    func dissmisPopUp() {
        outputRelay.accept(())
    }
    
}
