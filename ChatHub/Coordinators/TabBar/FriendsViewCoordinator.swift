//
//  FriendsViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

final class FriendsViewCoordinator: Coordinator {

    typealias Factory = FriendsViewFactory
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let servicesContainer: ServicesContainer


    init(navigationController: UINavigationController,
         servicesContainer: ServicesContainer) {
        self.navigationController = navigationController
        self.servicesContainer = servicesContainer
    }
    
    func start() {
        
        let viewModel = FriendsViewModel(services: servicesContainer)
        let friendsViewController = Factory.createFriendsViewController(with: viewModel)
        
        navigationController.setViewControllers([friendsViewController], animated: true)
    }
    
}
