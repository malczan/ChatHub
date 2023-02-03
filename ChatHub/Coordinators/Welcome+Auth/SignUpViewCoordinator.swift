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
    private let outputErrorRelay: PublishRelay<Error>
        
    init(navigationController: UINavigationController,
         outputRelay: PublishRelay<Output>,
         outputErrorRelay: PublishRelay<Error>) {
        self.navigationController = navigationController
        self.outputRelay = outputRelay
        self.outputErrorRelay = outputErrorRelay
    }
    
    func start() {
        let viewModel = SignUpViewModel(outputRelay: outputRelay,
                                        outputErrorRelay: outputErrorRelay)
        let signUpViewController = Factory.createSignUnViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([signUpViewController], animated: true)
    }
}
