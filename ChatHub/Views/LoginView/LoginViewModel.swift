//
//  LoginViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import Foundation
import RxRelay
import RxSwift

final class LoginViewModel {
    
    let usernameRelay = BehaviorSubject<String>(value: "")
    let passwordRelay = BehaviorSubject<String>(value: "")

    private let diposeBag = DisposeBag()
    
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
}
