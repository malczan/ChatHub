//
//  LoginViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxSwift
import RxRelay

final class SignInViewCoordinator: Coordinator {
    
    typealias Output = SignInViewModelOutput
    private typealias Factory = SignInViewControllerFactory
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay: PublishRelay<Output>
    private let outputErrorRelay: PublishRelay<Error>
    
    init(navigationController: UINavigationController,
         outputRelay: PublishRelay<Output>,
         outputErrorRelay: PublishRelay<Error>) {
        self.navigationController = navigationController
        self.outputRelay = outputRelay
        self.outputErrorRelay = outputErrorRelay
    }
    
    func start() {
        let viewModel = SignInViewModel(outputRelay: outputRelay, outputErrorRelay: outputErrorRelay)
        let loginViewController = Factory.createSignInViewController(viewModel: viewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }
}
