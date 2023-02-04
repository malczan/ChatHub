//
//  SettingsViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import Foundation
import RxSwift
import RxRelay

class SettingsViewModel {

    var username: String = ""
    let buttonInput = PublishSubject<Void>()
    
    private let userService = ConcreteUserService()
    private let authService = ConcreteAuthorizationService()
    
    private let outputErrorRelay: PublishRelay<Error>
    private let outputRelay: PublishRelay<Void>
    private let disposeBag = DisposeBag()
    
    init(outputErrorRelay: PublishRelay<Error>,
         outputRelay: PublishRelay<Void>) {
        self.outputErrorRelay = outputErrorRelay
        self.outputRelay = outputRelay
        bind()
    }
    
    func viewDidAppear() -> Observable<User>{
        return userService
                .fetchUserInformation()
    }
    
    private func bind() {
        buttonInput
            .subscribe(onNext: { [weak self] in
                self?.buttonLogoutTapped()
            })
            .disposed(by: disposeBag)
    }
    
    private func buttonLogoutTapped() {
        authService
            .signOutUser()
            .subscribe { [weak self] in
                self?.outputRelay.accept(())
            } onError: { [weak self] in
                self?.outputErrorRelay.accept($0)
            }
            .disposed(by: disposeBag)

    }
}
