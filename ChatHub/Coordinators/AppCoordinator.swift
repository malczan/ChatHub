//
//  AppCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true

        
        let welcomeViewCoordinator = WelcomeViewCoordinator(navigationController: navigationController)
        
        childCoordinators.append(welcomeViewCoordinator)
        
        welcomeViewCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
