//
//  ServicesContainer.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import Foundation

final class ServicesContainer:
    AuthorizationServiceContainer,
    ImageServiceContainer,
    UserServiceContainer {

    let authorizationService: AuthorizationService
    let imageService: ImageService
    let userService: UserService
    
    init(authorizationService: AuthorizationService,
         imageService: ImageService,
         userService: UserService) {
        
        self.authorizationService = authorizationService
        self.imageService = imageService
        self.userService = userService
    }
}
