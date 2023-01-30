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
    private let disposeBag = DisposeBag()

    
    init(window: UIWindow) {
        navigationController.isNavigationBarHidden = true
        self.window = window
        bind()
        
    }
    
    func start() {
        let welcomeViewCoordinator = WelcomeViewCoordinator(
            navigationController: navigationController,
            welcomeRelay: welcomeRelay)
        
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
                    print("@@@  forgot password")
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
    }
    
    private func showWelcomeView() {
        let welcomeViewCoordinator = WelcomeViewCoordinator(
            navigationController: navigationController,
            welcomeRelay: welcomeRelay)
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
            outputRelay: signUpRelay)
        signUpViewCoordinator.start()
        
    }
}
