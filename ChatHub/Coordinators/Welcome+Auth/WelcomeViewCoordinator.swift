//
//  WelcomeViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import Swinject
import RxSwift
import RxRelay

final class WelcomeViewCoordinator: Coordinator {
    
    typealias Output = WelcomeViewModelOutput
    private typealias Factory = WelcomeViewControllerFactory
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let window: UIWindow
    private let resolver: Resolver
    
    private let appCoordinatorRelay: PublishRelay<AppCoordinatorSignals>

    private let welcomeRelay = PublishRelay<WelcomeViewModelOutput>()
    private let signInRelay = PublishRelay<SignInViewModelOutput>()
    private let signUpRelay = PublishRelay<SignUpViewModelOutput>()
    private let authorizationErrorRelay = PublishRelay<Error>()
    private let forgotPasswordRelay = PublishRelay<ForgotPasswordViewModelOutput>()
    private let popUpRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    
    init(appCoordinatorRelay: PublishRelay<AppCoordinatorSignals>,
         navigationController: UINavigationController,
         window: UIWindow,
         resolver: Resolver) {
        self.appCoordinatorRelay = appCoordinatorRelay
        self.navigationController = navigationController
        self.window = window
        self.resolver = resolver
        
        bind()
    }
    
    func start() {
        let viewModel = WelcomeViewModel(outputScreenSelected: welcomeRelay)
        let welcomeViewController =  Factory.createWelcomeViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([welcomeViewController], animated: true)
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
                    self?.appCoordinatorRelay.accept(.tabBarView)
                }
            }).disposed(by: disposeBag)
        
        signUpRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .alreadyHaveAccount:
                    self?.showSignInView()
                case .signedUp:
                    self?.appCoordinatorRelay.accept(.tabBarView)
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
            outputErrorRelay: authorizationErrorRelay,
            resolver: resolver)
        signInViewCoordinator.start()
    }
    
    private func showSignUpView() {
        let signUpViewCoordinator = SignUpViewCoordinator(
            navigationController: navigationController,
            outputRelay: signUpRelay,
            outputErrorRelay: authorizationErrorRelay,
            resolver: resolver)
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


