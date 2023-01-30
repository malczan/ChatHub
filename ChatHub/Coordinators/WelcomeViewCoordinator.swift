//
//  WelcomeViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxSwift
import RxRelay

final class WelcomeViewCoordinator: Coordinator {
    
    private typealias Factory = WelcomeViewControllerFactory
    private typealias Output = WelcomeViewModelOutput
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay = PublishRelay<Output>()
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        bind()
    }
    
    func start() {
        let viewModel = WelcomeViewModel(outputScreenSelected: outputRelay)
        let welcomeViewController =  Factory.createWelcomeViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([welcomeViewController], animated: false)
    }
    
    private func bind() {
        outputRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                    case .signIn:
                        self?.signInSelected()
                    case .singUp:
                        self?.signUpSelected()
            }
        }).disposed(by: disposeBag)
    }
    
    private func signInSelected() {
        let signInCoordinator = SignInViewCoordinator(navigationController: navigationController)
        
        childCoordinators.append(signInCoordinator)
        
        signInCoordinator.start()
    }
    
    private func signUpSelected() {
        let signUpCoordinator = SignUpViewCoordinator(navigationController: navigationController)
        
        childCoordinators.append(signUpCoordinator)
        
        signUpCoordinator.start()
        
    }
}
