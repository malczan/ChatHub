//
//  SignUpViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxSwift
import RxRelay

final class SignUpViewCoordinator: Coordinator {
    
    typealias Output = SignUpViewModelOutput
    private typealias Factory = SignUpViewControllerFactory
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay: PublishRelay<Output>
        
    init(navigationController: UINavigationController,
         outputRelay: PublishRelay<Output>) {
        self.navigationController = navigationController
        self.outputRelay = outputRelay
    }
    
    func start() {
        let viewModel = SignUpViewModel(outputRelay: outputRelay)
        let signUpViewController = Factory.createSignUnViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([signUpViewController], animated: true)
    }
}
