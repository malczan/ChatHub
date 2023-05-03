//
//  DefaultAssembly.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 25/03/2023.
//

import Foundation
import Swinject

final class DefaultAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(AuthorizationService.self) { _ in
            ConcreteAuthorizationService()
        }
        
        container.register(DataObserverService.self) { _ in
            ConcreteDataObserverService()
        }
        
        container.register(FriendsService.self) { resolver in
            let userService = resolver.resolve(UserService.self)!
            return ConcreteFriendsService(userService: userService)
        }
        
        container.register(ImageService.self) { resolver in
            let userService = resolver.resolve(UserService.self)!
            return ConcreteImageService(userService: userService)
        }
        
        container.register(UserService.self) { _ in
            ConcreteUserService()
        }
        
        
    }
}
