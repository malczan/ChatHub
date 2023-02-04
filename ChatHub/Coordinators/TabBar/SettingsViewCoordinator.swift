//
//  SettingsViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

final class SettingsViewCoordinator: Coordinator {
    
    private typealias Factory = SettingsViewControllerFactory
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SettingsViewModel()
        let settingsViewController = Factory.createSettingsViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([settingsViewController], animated: true)
    }
    
}
