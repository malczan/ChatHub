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
    
    typealias Output = WelcomeViewModelOutput
    private typealias Factory = WelcomeViewControllerFactory
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let window: UIWindow
    
    private let welcomeRelay = PublishRelay<WelcomeViewModelOutput>()
    private let signInRelay = PublishRelay<SignInViewModelOutput>()
    private let signUpRelay = PublishRelay<SignUpViewModelOutput>()
    private let authorizationErrorRelay = PublishRelay<Error>()
    private let forgotPasswordRelay = PublishRelay<ForgotPasswordViewModelOutput>()
    private let popUpRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    
    init(navigationController: UINavigationController,
         window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        bind()
    }
    
    func start() {
        let viewModel = WelcomeViewModel(outputScreenSelected: welcomeRelay)
        let welcomeViewController =  Factory.createWelcomeViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([welcomeViewController], animated: false)
    }
    
    private func bind() {
        welcomeRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                    case .signIn:
                        self?.showSignInView()
                    case .singUp:
                        self?.showSignUpView()
            }
        }).disposed(by: disposeBag)
        
        signInRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .alreadyHaveAccount:
                    self?.showSignUpView()
                case .forgotPassword:
                    self?.showForgotPasswordView()
                case .signedIn:
                    print("@@@ signed in")
                }
            }).disposed(by: disposeBag)
        
        signUpRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .alreadyHaveAccount:
                    self?.showSignInView()
                case .signedUp:
                    print("@")
                }
            })
            .disposed(by: disposeBag)
        
        authorizationErrorRelay
            .subscribe(onNext: { [weak self] in
                self?.showPopUpView(with: $0)
            })
            .disposed(by: disposeBag)
        
        forgotPasswordRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .cofirm:
                    self?.showSignInView()
                case .goBack:
                    self?.showSignInView()
                }
            }).disposed(by: disposeBag)
        
        popUpRelay
            .subscribe(onNext: { [weak self] in
                self?.hidePopUpView()
            })
            .disposed(by: disposeBag)
    }
    
    private func showSignInView() {
        let signInViewCoordinator = SignInViewCoordinator(
            navigationController: navigationController,
            outputRelay: signInRelay,
            outputErrorRelay: authorizationErrorRelay)
        signInViewCoordinator.start()
    }
    
    private func showSignUpView() {
        let signUpViewCoordinator = SignUpViewCoordinator(
            navigationController: navigationController,
            outputRelay: signUpRelay,
            outputErrorRelay: authorizationErrorRelay)
        signUpViewCoordinator.start()
    }
    
    private func showForgotPasswordView() {
        let forgotPasswordViewCoordinator = ForgotPasswordViewCoordinator(
            navigationController: navigationController,
            outplutRelay: forgotPasswordRelay)
        forgotPasswordViewCoordinator.start()
    }
    
    private func showPopUpView(with error: Error) {
        let viewModel = PopUpViewModel(error: error, outputRelay: popUpRelay)
        let popUpViewController = PopUpViewControllerFactory.createPopUpViewController(viewModel: viewModel)
        popUpViewController.modalPresentationStyle = .custom
        window.rootViewController?.present(popUpViewController, animated: false)
        window.makeKeyAndVisible()
    }
    
    private func hidePopUpView() {
        window.rootViewController?.dismiss(animated: false)
    }
}


