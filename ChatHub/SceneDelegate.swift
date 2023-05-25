//
//  SceneDelegate.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        let assembler = AssemblerFactory.make()
        let servicesContainer = makeServicesContainer(resolver: assembler.resolver)
        self.appCoordinator = AppCoordinator(window: window, servicesContainer: servicesContainer)
        appCoordinator?.start()
    }
}

private extension SceneDelegate {
    func makeServicesContainer(resolver: Resolver) -> ServicesContainer {
        return ServicesContainer(
            authorizationService: resolver.resolve(AuthorizationService.self)!,
            dataObserverService: resolver.resolve(DataObserverService.self)!,
            friendsService: resolver.resolve(FriendsService.self)!,
            imageService: resolver.resolve(ImageService.self)!,
            messageService: resolver.resolve(MessageService.self)!,
            userService: resolver.resolve(UserService.self)!)
    }
}
