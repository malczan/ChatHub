//
//  MessegesViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit
import RxRelay
import RxSwift

final class MessegesViewCoordinator: Coordinator {
    
    private typealias Factory = MessagesViewFactory
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay: PublishRelay<String?>
    private let disposeBag = DisposeBag()
    private let servicesContainer: ServicesContainer

    init(navigationController: UINavigationController,
         outputRelay: PublishRelay<String?>,
         servicesContainer: ServicesContainer) {
        self.navigationController = navigationController
        self.outputRelay = outputRelay
        self.servicesContainer = servicesContainer
    }
    
    func start() {
        let viewModel = MessagesViewModel(
            services: servicesContainer,
            outputRelay: outputRelay)
        let messegesViewController = Factory.createMessegesViewController(with: viewModel)
        
        navigationController.setViewControllers([messegesViewController], animated: true)
    }
}
