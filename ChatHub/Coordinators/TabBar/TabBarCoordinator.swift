//
//  TabBarCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let window: UIWindow

    
    init(navigationController: UINavigationController,
         window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        let tabBarViewController = TabBarViewController()
        navigationController.setViewControllers([tabBarViewController], animated: false)
    }
    
    
}
