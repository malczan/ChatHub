//
//  AppCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxSwift
import RxRelay

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    let navigationController = UINavigationController()
    
    private let welcomeRelay = PublishRelay<WelcomeViewModelOutput>()
    private let signInRelay = PublishRelay<SignInViewModelOutput>()
    private let signUpRelay = PublishRelay<SignUpViewModelOutput>()
    private let signUpErrorRelay = PublishRelay<Error>()
    private let forgotPasswordRelay = PublishRelay<ForgotPasswordViewModelOutput>()
    private let popUpRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()

    
    init(window: UIWindow) {
        navigationController.isNavigationBarHidden = true
        self.window = window
        bind()
        
    }
    
    func start() {
        let welcomeViewCoordinator = WelcomeViewCoordinator(
            navigationController: navigationController,
            outputRelay: welcomeRelay)
        
        childCoordinators.append(welcomeViewCoordinator)

        welcomeViewCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
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
        
        signUpErrorRelay
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
    
    private func showWelcomeView() {
        let welcomeViewCoordinator = WelcomeViewCoordinator(
            navigationController: navigationController,
            outputRelay: welcomeRelay)
        welcomeViewCoordinator.start()
    }
    
    private func showSignInView() {
        let signInViewCoordinator = SignInViewCoordinator(
            navigationController: navigationController,
            outputRelay: signInRelay)
        signInViewCoordinator.start()
    }
    
    private func showSignUpView() {
        let signUpViewCoordinator = SignUpViewCoordinator(
            navigationController: navigationController,
            outputRelay: signUpRelay,
            outputErrorRelay: signUpErrorRelay)
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
