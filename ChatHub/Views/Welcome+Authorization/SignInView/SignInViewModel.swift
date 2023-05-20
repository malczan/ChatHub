//
//  SignInViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import Foundation
import RxRelay
import RxSwift

public enum SignInViewModelOutput {
    case alreadyHaveAccount
    case forgotPassword
    case signedIn
}

final class SignInViewModel {
    
    typealias Output = SignInViewModelOutput
    typealias ServicesContainer = AuthorizationServiceContainer
    
    let passwordRelay = BehaviorSubject<String>(value: "")
    let usernameRelay = BehaviorSubject<String>(value: "")

    private let services: ServicesContainer
    
    private let outputErrorRelay: PublishRelay<Error>
    private let outputRelay: PublishRelay<Output>
    private let disposeBag = DisposeBag()
    
    init(services: ServicesContainer,
         outputRelay: PublishRelay<Output>,
         outputErrorRelay: PublishRelay<Error>) {
        self.services = services
        self.outputRelay = outputRelay
        self.outputErrorRelay = outputErrorRelay
    }
    
    func isValid() -> Observable<Bool> {
        return Observable
            .combineLatest(isUsernameValid(), isPasswordValid())
            .map { $0 && $1 }
    }
    
    func signInTapped() {
        services
            .authorizationService
            .signInUser(
                withEmail: try! usernameRelay.value(),
                password: try! passwordRelay.value())
            .subscribe { [weak self] _ in
                self?.outputRelay.accept(.signedIn)
            } onError: { [weak self] in
                self?.outputErrorRelay.accept($0)
            }
            .disposed(by: disposeBag)
        
    }
    func forgotPasswordTapped() {
        outputRelay.accept(.forgotPassword)
    }
    
    func createAccountTapped() {
        outputRelay.accept(.alreadyHaveAccount)
    }
    
    private func isUsernameValid() -> Observable<Bool> {
        return usernameRelay.map { $0.count > 5 }
    }
    
    private func isPasswordValid() -> Observable<Bool> {
        return passwordRelay.map { $0.count > 5 }
    }
    
}
