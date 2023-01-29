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
    case signIn
}

final class SignInViewModel {
    
    typealias Output = SignInViewModelOutput
    
    let passwordRelay = BehaviorSubject<String>(value: "")
    let usernameRelay = BehaviorSubject<String>(value: "")
    
    let alreadyHaveAccountSubject = PublishSubject<Void>()
    let forgotPasswordSubject = PublishSubject<Void>()
    let signInSubject = PublishSubject<Void>()
    
    private let outputRelay: PublishRelay<Output>
    private let disposeBag = DisposeBag()
    
    init(outputRelay: PublishRelay<Output>) {
        self.outputRelay = outputRelay
        bind()
    }
    
    func isValid() -> Observable<Bool> {
        return Observable
            .combineLatest(isUsernameValid(), isPasswordValid())
            .map { $0 && $1 }
    }
    
    private func isUsernameValid() -> Observable<Bool> {
        return usernameRelay.map { $0.count > 5 }
    }
    
    private func isPasswordValid() -> Observable<Bool> {
        return passwordRelay.map { $0.count > 5 }
    }
    
    private func bind() {
        alreadyHaveAccountSubject.subscribe(onNext: {[weak self] _ in
            self?.outputRelay.accept(.alreadyHaveAccount)
        }).disposed(by: disposeBag)
        
        forgotPasswordSubject.subscribe(onNext: { [weak self] _ in
            self?.outputRelay.accept(.forgotPassword)
            print("@@@@@")
        }).disposed(by: disposeBag)
        
        signInSubject.subscribe(onNext: {[weak self] _ in
            self?.outputRelay.accept(.signIn)
        }).disposed(by: disposeBag)
        
    }
    
}
