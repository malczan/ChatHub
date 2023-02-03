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
    
    let emailRelay = BehaviorSubject<String>(value: "")
    let passwordRelay = BehaviorSubject<String>(value: "")
    let confirmPasswordRelay = BehaviorSubject<String>(value: "")
    
    let signUnSubject = PublishSubject<Void>()
    
    private let authorizationService = ConcreteAuthorizationService()
    
    private let outputErrorRelay: PublishRelay<Error>
    private let outputRelay: PublishRelay<Output>
    private let disposeBag = DisposeBag()
    
    private let diposeBag = DisposeBag()
    
    init(outputRelay: PublishRelay<Output>,
         outputErrorRelay: PublishRelay<Error>) {
        self.outputRelay = outputRelay
        self.outputErrorRelay = outputErrorRelay
        bind()
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
    
    private func bind() {
        signUnSubject
            .subscribe(onNext: { [weak self] in
                self?.signUpTapped()
            })
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
    
    private func signUpTapped() {
        authorizationService.signUpUser(
            with: try! emailRelay.value(),
            password: try! passwordRelay.value(),
            completion: { [weak self] in
                self?.handleSigUpResult(with: $0)
        })
    }
    
    private func handleSigUpResult(with result: Result<Void, Error>) {
        switch result {
        case .success:
            print("Sucessfully signed up")
        case .failure(let error):
            outputErrorRelay.accept(error)
        }
    }
    
    
    
}
