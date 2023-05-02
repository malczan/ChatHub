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
    typealias ServicesContainer =
    AuthorizationServiceContainer &
    UserServiceContainer
    
        
    var userSubject = PublishRelay<User>()
    private let services: ServicesContainer
    
    private let outputErrorRelay: PublishRelay<Error>
    private let outputRelay: PublishRelay<Output>
    private let disposeBag = DisposeBag()
    
    init(services: ServicesContainer,
         outputErrorRelay: PublishRelay<Error>,
         outputRelay: PublishRelay<Output>) {
        self.services = services
        self.outputErrorRelay = outputErrorRelay
        self.outputRelay = outputRelay
    }
    
    var user: Driver<User?> {
        return services
            .userService
            .userRelay
            .asDriver(onErrorDriveWith: Driver.never())
    }
    
    func settings() -> [SettingModel] {
        return [
            SettingModel(title: "Upload photo", icon: "photo"),
            SettingModel(title: "Update username", icon: "person"),
            SettingModel(title: "Notifications", icon: "bell")
        ]
    }
    
    func selected(cell: SettingModel) {
        outputRelay
            .accept(.updatePhoto)
    }
    
    func buttonLogoutTapped() {
        services
            .authorizationService
            .signOutUser()
            .subscribe { [weak self] in
                self?.outputRelay.accept(.signOut)
            } onError: { [weak self] in
                self?.outputErrorRelay.accept($0)
            }
            .disposed(by: disposeBag)
    }
}
