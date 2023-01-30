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
    
    private typealias Factory = SignUpViewControllerFactory
    private typealias Output = SignUpViewModelOutput
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay = PublishRelay<Output>()
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        bind()
        let viewModel = SignUpViewModel(outputRelay: outputRelay)
        let signUpViewController = Factory.createSignUnViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([signUpViewController], animated: true)
    }
    
    private func bind() {
        outputRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .alreadyHaveAccount:
                    self?.showSignInViewController()
                case .signedUp:
                    print("@")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func showSignInViewController() {
        let signInCoordinator = SignInViewCoordinator(navigationController: navigationController)
        signInCoordinator.start()
        
    }
    
    func dismiss() {
        navigationController.popToRootViewController(animated: false)
    }
    
   
    
}
