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
    
    private let disposeBag = DisposeBag()
    private let outputRelay: PublishRelay<Output>
    
    init(outputScreenSelected: PublishRelay<Output>) {
        self.outputRelay = outputScreenSelected
    }

    func signInButtonTapped() {
        outputRelay.accept(.signIn)
    }
    
    func signUpButtonTapped() {
        outputRelay.accept(.singUp)
    }

}
