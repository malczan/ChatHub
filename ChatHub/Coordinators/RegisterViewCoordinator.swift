//
//  SignUpViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit

final class RegisterViewCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registerViewController = RegisterViewController()
        navigationController.setViewControllers([registerViewController], animated: true)
    }
    
}
