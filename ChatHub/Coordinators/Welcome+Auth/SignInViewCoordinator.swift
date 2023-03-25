//
//  LoginViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxSwift
import RxRelay
import Swinject

final class SignInViewCoordinator: Coordinator {
    
    typealias Output = SignInViewModelOutput
    private typealias Factory = SignInViewControllerFactory
    
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
        let viewModel = SignInViewModel(authorizationService: authorizationService, outputRelay: outputRelay, outputErrorRelay: outputErrorRelay)
        let loginViewController = Factory.createSignInViewController(viewModel: viewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }
}
