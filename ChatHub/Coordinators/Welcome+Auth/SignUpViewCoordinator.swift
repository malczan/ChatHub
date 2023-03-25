//
//  SignUpViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import Swinject
import RxSwift
import RxRelay

final class SignUpViewCoordinator: Coordinator {
    
    typealias Output = SignUpViewModelOutput
    private typealias Factory = SignUpViewControllerFactory
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay: PublishRelay<Output>
    private let outputErrorRelay: PublishRelay<Error>
    private let resolver: Resolver
        
    init(navigationController: UINavigationController,
         outputRelay: PublishRelay<Output>,
         outputErrorRelay: PublishRelay<Error>,
         resolver: Resolver) {
        self.navigationController = navigationController
        self.outputRelay = outputRelay
        self.outputErrorRelay = outputErrorRelay
        self.resolver = resolver
    }
    
    func start() {
        let authorizationService = resolver.resolve(AuthorizationService.self)!
        let viewModel = SignUpViewModel(authorizationService: authorizationService,
                                        outputRelay: outputRelay,
                                        outputErrorRelay: outputErrorRelay)
        let signUpViewController = Factory.createSignUnViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([signUpViewController], animated: true)
    }
}
