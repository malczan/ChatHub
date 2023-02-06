//
//  SettingsViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

enum SettingsViewModelOutput {
    case signOut
    case updatePhoto
}

class SettingsViewModel {
    
    typealias Output = SettingsViewModelOutput
    
    let buttonInput = PublishSubject<Void>()
    
    var userSubject = PublishRelay<User>()
    private let userService = ConcreteUserService()
    private let authService = ConcreteAuthorizationService()
    
    private let outputErrorRelay: PublishRelay<Error>
    private let outputRelay: PublishRelay<Output>
    private let disposeBag = DisposeBag()
    
    init(outputErrorRelay: PublishRelay<Error>,
         outputRelay: PublishRelay<Output>) {
        self.outputErrorRelay = outputErrorRelay
        self.outputRelay = outputRelay
        bind()
    }
    
    
    var userObservable: Observable<User> {
        return userService.user.asObservable()
    }
    
    func settings() -> [SettingModel] {
        return [
            SettingModel(title: "Upload photo", icon: "photo"),
            SettingModel(title: "Update username", icon: "person"),
            SettingModel(title: "Notifications", icon: "bell")
        ]
    }
    
    func refreshUser() {
        userService.refreshUserInfo()
    }
    
    func selected(cell: SettingModel) {
        outputRelay
            .accept(.updatePhoto)
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
                self?.outputRelay.accept(.signOut)
            } onError: { [weak self] in
                self?.outputErrorRelay.accept($0)
            }
            .disposed(by: disposeBag)
    }
}
