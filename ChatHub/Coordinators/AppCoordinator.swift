//
//  AppCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit
import RxSwift
import RxRelay
import Firebase

enum AppCoordinatorSignals {
    case welcomeView
    case tabBarView
}

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    let navigationController = UINavigationController()
    private let appCoordinatorRelay = PublishRelay<AppCoordinatorSignals>()
    private let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        navigationController.isNavigationBarHidden = true
        self.window = window
        bind()
    }
    
    func start() {
        
        let service = ConcreteUserService()
                
        if service.activeSession {
            showTabBarView()
        } else {
            showWelcomeView()
        }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func bind() {
        appCoordinatorRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .tabBarView:
                    self?.showTabBarView()
                case .welcomeView:
                    self?.showWelcomeView()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func showWelcomeView() {
        let welcomeViewCoordinator = WelcomeViewCoordinator(
            appCoordinatorRelay: appCoordinatorRelay,
            navigationController: navigationController,
            window: window)
        
        childCoordinators.append(welcomeViewCoordinator)

        welcomeViewCoordinator.start()
    }
    
    private func showTabBarView() {
        let tabBarCoordinator = TabBarCoordinator(
            navigationController: navigationController,
            window: window)
        
        childCoordinators.append(tabBarCoordinator)
        
        tabBarCoordinator.start()
    }
}
