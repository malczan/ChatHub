//
//  WelcomeViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import Foundation
import RxSwift
import RxRelay

public enum WelcomeViewModelOutput {
    case signIn
    case singUp
}

final class WelcomeViewModel {
    
    typealias Output = WelcomeViewModelOutput
    
    let signInSubject = PublishSubject<Void>()
    let signUpSubject = PublishSubject<Void>()

    private let disposeBag = DisposeBag()
    private let outputRelay: PublishRelay<Output>
    

    init(outputScreenSelected: PublishRelay<Output>) {
        self.outputRelay = outputScreenSelected
        bind()
    }
    
    private func bind() {
        signInSubject.subscribe(onNext: {[weak self] _ in
            self?.outputRelay.accept(.signIn)
        }).disposed(by: disposeBag)
        
        signUpSubject.subscribe(onNext: { [weak self] _ in
            self?.outputRelay.accept(.singUp)
        }).disposed(by: disposeBag)
    }

}
