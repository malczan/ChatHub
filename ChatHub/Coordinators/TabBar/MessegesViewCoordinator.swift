//
//  MessegesViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

final class MessegesViewCoordinator: Coordinator {
    
    private typealias Factory = MessegesViewFactory
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MessegesViewModel()
        let messegesViewController = Factory.createMessegesViewController(with: viewModel)
        
        navigationController.setViewControllers([messegesViewController], animated: true)
    }
    
}
