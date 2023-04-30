//
//  SignUpViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import Foundation
import RxRelay
import RxSwift

enum SignUpViewModelOutput: String {
    case alreadyHaveAccount
    case signedUp
}

final class SignUpViewModel {
    
    typealias Output = SignUpViewModelOutput
    
    let usernameRelay = BehaviorSubject<String>(value: "")
    let emailRelay = BehaviorSubject<String>(value: "")
    let passwordRelay = BehaviorSubject<String>(value: "")
    let confirmPasswordRelay = BehaviorSubject<String>(value: "")
        
    private let authorizationService: AuthorizationService
    
    private let outputErrorRelay: PublishRelay<Error>
    private let outputRelay: PublishRelay<Output>
    private let disposeBag = DisposeBag()
    
    private let diposeBag = DisposeBag()
    
    init(authorizationService: AuthorizationService,
         outputRelay: PublishRelay<Output>,
         outputErrorRelay: PublishRelay<Error>) {
        self.authorizationService = authorizationService
        self.outputRelay = outputRelay
        self.outputErrorRelay = outputErrorRelay
    }
    
    func isValid() -> Observable<Bool> {
        return Observable
            .combineLatest(
                isEmailValid(),
                isPasswordValid(),
                isConfirmPasswordValid(),
                arePasswordTheSame())
            .map { $0 && $1 && $2 && $3}
    }
    
    func alreadyHaveAccountTapped() {
        outputRelay.accept(.alreadyHaveAccount)
    }
    
    func signUpTapped() {
        authorizationService.signUpUser(
            withUsername: try! usernameRelay.value(),
            email: try! emailRelay.value(),
            password: try! passwordRelay.value())
        .subscribe { [weak self] _ in
            self?.outputRelay.accept(.signedUp)
        } onError: { [weak self] in
            self?.outputErrorRelay.accept($0)
        }
        .disposed(by: disposeBag)
    }

    func arePasswordTheSame() -> Observable<Bool>{
        return Observable
            .combineLatest(passwordRelay, confirmPasswordRelay)
            .map { $0 == $1}
    }
    
    private func isEmailValid() -> Observable<Bool> {
        return emailRelay.map { $0.count > 5 }
    }
    
    private func isPasswordValid() -> Observable<Bool> {
        return passwordRelay.map { $0.count > 5 }
    }
    
    private func isConfirmPasswordValid() -> Observable<Bool> {
        return confirmPasswordRelay.map { $0.count > 5 }
    }
}
