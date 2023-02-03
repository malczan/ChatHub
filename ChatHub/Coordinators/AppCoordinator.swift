//
//  AppCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxSwift
import RxRelay

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    let navigationController = UINavigationController()
    private let isUserLogged = true // hardcoded for now
    
    init(window: UIWindow) {
        navigationController.isNavigationBarHidden = true
        self.window = window        
    }
    
    func start() {
        if isUserLogged {
            showWelcomeView()
        } else {
            //
        }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func showWelcomeView() {
        let welcomeViewCoordinator = WelcomeViewCoordinator(
            navigationController: navigationController,
            window: window)
        
        childCoordinators.append(welcomeViewCoordinator)

        welcomeViewCoordinator.start()
    }
}
