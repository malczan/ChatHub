//
//  MessegesViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

final class MessegesViewCoordinator: Coordinator {
        
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
//        let viewModel = SettingsViewModel()
        let messegesViewController = MessegesViewController()
        
        navigationController.setViewControllers([messegesViewController], animated: true)
    }
    
}
