//
//  SettingsViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import Foundation
import RxSwift

class SettingsViewModel {

    var userSubject = PublishSubject<User>()
    private let userService = ConcreteUserService()
    private let authService = ConcreteAuthorizationService()
    
    
    func viewDidAppear() {
        userService.fetchUserInformation { [weak self] user in
            DispatchQueue.main.async {
                 self?.userSubject.onNext(user)
             }
        }
    }
    
    
}
