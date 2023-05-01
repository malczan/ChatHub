//
//  TabBarViewModel.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 25/03/2023.
//

import Foundation

final class TabBarViewModel {
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func viewDidAppear() {
        userService.refreshUserInfo()
    }
}
