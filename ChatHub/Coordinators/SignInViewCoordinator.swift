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
    
    private typealias Factory = SignInViewControllerFactory
    private typealias Output = SignInViewModelOutput
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay = PublishRelay<Output>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SignInViewModel(outputRelay: outputRelay)
        let loginViewController = Factory.createSignInViewController(viewModel: viewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }
    
    func dismiss() {
        
    }
    
    
}
