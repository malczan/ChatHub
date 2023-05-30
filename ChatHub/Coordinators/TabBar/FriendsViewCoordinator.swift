//
//  FriendsViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit
import RxRelay

final class FriendsViewCoordinator: Coordinator {

    typealias Factory = FriendsViewFactory
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let servicesContainer: ServicesContainer
    private let outputRelay:  PublishRelay<String?>


    init(navigationController: UINavigationController,
         servicesContainer: ServicesContainer,
         outputRelay:  PublishRelay<String?>) {
        self.navigationController = navigationController
        self.servicesContainer = servicesContainer
        self.outputRelay = outputRelay
    }
    
    func start() {
        
        let viewModel = FriendsViewModel(
            services: servicesContainer,
            outputRelay: outputRelay)
        let friendsViewController = Factory.createFriendsViewController(with: viewModel)
        
        navigationController.setViewControllers([friendsViewController], animated: true)
    }
    
}
