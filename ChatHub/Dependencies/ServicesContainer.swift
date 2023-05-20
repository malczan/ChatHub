//
//  ServicesContainer.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import Foundation

final class ServicesContainer:
    AuthorizationServiceContainer,
    DataObserverServiceContainer,
    FriendsServiceContainer,
    ImageServiceContainer,
    UserServiceContainer {

    let authorizationService: AuthorizationService
    let dataObserverService: DataObserverService
    let friendsService: FriendsService
    let imageService: ImageService
    let userService: UserService
    
    init(authorizationService: AuthorizationService,
         dataObserverService: DataObserverService,
         friendsService: FriendsService,
         imageService: ImageService,
         userService: UserService) {
        
        self.authorizationService = authorizationService
        self.friendsService = friendsService
        self.dataObserverService = dataObserverService
        self.imageService = imageService
        self.userService = userService
    }
}
