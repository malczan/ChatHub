//
//  FriendsViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

final class FriendsViewCoordinator: Coordinator {
        
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let viewModel = SettingsViewModel()
        let friendsViewController = FriendsViewController()
        
        navigationController.setViewControllers([friendsViewController], animated: true)
    }
    
}
