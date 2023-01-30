//
//  SignUpViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import Foundation
import RxRelay
import RxSwift

enum SignUpViewModelOutput {
    case alreadyHaveAccount
    case signedUp
}

final class SignUpViewModel {
    
    typealias Output = SignUpViewModelOutput
    
    let usernameRelay = BehaviorSubject<String>(value: "")
    let emailRelay = BehaviorSubject<String>(value: "")
    let passwordRelay = BehaviorSubject<String>(value: "")
    let confirmPasswordRelay = BehaviorSubject<String>(value: "")
    
    private let outputRelay: PublishRelay<Output>
    private let disposeBag = DisposeBag()
    
    private let diposeBag = DisposeBag()
    
    init(outputRelay: PublishRelay<Output>) {
        self.outputRelay = outputRelay
    }
    
    func isValid() -> Observable<Bool> {
        return Observable
            .combineLatest(
                isUsernameValid(),
                isEmailValid(),
                isPasswordValid(),
                isConfirmPasswordValid())
            .map { $0 && $1 && $2 && $3}
    }
    
    func alreadyHaveAccountTapped() {
        outputRelay.accept(.alreadyHaveAccount)
    }
    
    private func isUsernameValid() -> Observable<Bool> {
        return usernameRelay.map { $0.count > 5 }
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
