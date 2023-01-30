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
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    func start() {
        bind()
        let viewModel = SignInViewModel(outputRelay: outputRelay)
        let loginViewController = Factory.createSignInViewController(viewModel: viewModel)
        navigationController.setViewControllers([loginViewController], animated: true)
    }
    
    private func bind() {
        outputRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .alreadyHaveAccount:
                    self?.showSignUpViewController()
                case .forgotPassword:
                    print("@@@  forgot password")
                case .signedIn:
                    print("@@@ signed in")
                }
            }).disposed(by: disposeBag)
    }
    
    private func showSignUpViewController() {
        dismiss()
        let signUpCoordinator = SignUpViewCoordinator(navigationController: navigationController)
        signUpCoordinator.start()
    }
    
    private func dismiss() {
        navigationController.dismiss(animated: false)
    }
    
    
}
