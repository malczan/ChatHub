//
//  ForgotPasswordViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 30/01/2023.
//

import Foundation
import RxSwift
import RxRelay

enum ForgotPasswordViewModelOutput {
    case confirm
    case goBack
}

class ForgotPasswordViewModel {
    
    typealias Output = ForgotPasswordViewModelOutput
    
    let emailRelay = BehaviorSubject<String>(value: "")
    let usernameRelay = BehaviorSubject<String>(value: "")
        
    private let outputRelay: PublishRelay<Output>
    private let disposeBag = DisposeBag()
    
    init(outputRelay: PublishRelay<Output>) {
        self.outputRelay = outputRelay
    }
    
    func isValid() -> Observable<Bool> {
        return Observable
            .combineLatest(isUsernameValid(), isEmailValid())
            .map { $0 && $1 }
    }
    
    func confirmTapped() {
        outputRelay.accept(.confirm)
    }
    
    func goBackTapped() {
        outputRelay.accept(.goBack)
    }

    private func isUsernameValid() -> Observable<Bool> {
        return usernameRelay.map { $0.count > 5 }
    }
    
    private func isEmailValid() -> Observable<Bool> {
        return emailRelay.map { $0.count > 5 }
    }
    
}
