//
//  TabBarCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit
import RxSwift
import RxRelay

final class TabBarCoordinator: Coordinator {
    
    private typealias TabBarFactory = TabBarViewControllerFactory
    private typealias SettingsFactory = SettingsViewControllerFactory
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let appCoordinatorRelay: PublishRelay<AppCoordinatorSignals>
    private let navigationController: UINavigationController
    private let window: UIWindow
    
    private let settingsOutputRelay = PublishRelay<Void>()
    private let errorRelay = PublishRelay<Error>()
    private let popUpRelay = PublishRelay<Void>()

    private let disposeBag = DisposeBag()
    
    init(appCoordinatorRelay: PublishRelay<AppCoordinatorSignals>,
         navigationController: UINavigationController,
         window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        self.appCoordinatorRelay = appCoordinatorRelay
        bind()
    }
    
    func start() {
        
        let tabBarViewController = TabBarFactory.createTabBarViewController()
        
        let messgesNavigationController = UINavigationController()
        messgesNavigationController.tabBarItem = UITabBarItem(
            title: "Messeges",
            image: UIImage(systemName: "message"),
            tag: 0)
        let messegesCoordinator = MessegesViewCoordinator(navigationController: messgesNavigationController)
        messegesCoordinator.start()
        
        let friendsNavigationController = UINavigationController()
        friendsNavigationController.tabBarItem = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.2"),
            tag: 1)
        let friendsCoordinator = FriendsViewCoordinator(navigationController: friendsNavigationController)
        friendsCoordinator.start()
        
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 2)
        let settingsCoordinator = SettingsViewCoordinator(
            outputErrorRelay: errorRelay,
            outputRelay: settingsOutputRelay,
            navigationController: settingsNavigationController)
        settingsCoordinator.start()
        
        tabBarViewController.viewControllers = [messgesNavigationController, friendsNavigationController, settingsNavigationController]
        navigationController.setViewControllers([tabBarViewController], animated: true)
    }
    
    private func bind() {
        settingsOutputRelay
            .subscribe(onNext: { [weak self] _ in
                self?.appCoordinatorRelay.accept(.welcomeView)
            })
            .disposed(by: disposeBag)
        
        errorRelay
            .subscribe(onNext: { [weak self] in
                self?.showPopUpView(with: $0)
            })
            .disposed(by: disposeBag)
        
        popUpRelay
            .subscribe(onNext: { [weak self] in
                self?.hidePopUpView()
            })
            .disposed(by: disposeBag)
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
