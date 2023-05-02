//
//  TabBarCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit
import Swinject
import RxSwift
import RxRelay

final class TabBarCoordinator: Coordinator {
    
    private typealias TabBarFactory = TabBarViewControllerFactory
    private typealias SettingsFactory = SettingsViewControllerFactory
    private typealias PhotoPickerFactory = PhotoPickerViewControllerFactory
    
    private typealias SettingsOutput = SettingsViewModelOutput
    private typealias PhotoPickerOutput = PhotoPickerViewModelOutput
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let appCoordinatorRelay: PublishRelay<AppCoordinatorSignals>
    private let navigationController: UINavigationController
    private let window: UIWindow
    private let servicesContainer: ServicesContainer
    
    private let settingsOutputRelay = PublishRelay<SettingsOutput>()

    private let photoPickerOutputRelay = PublishRelay<PhotoPickerOutput>()
    
    private let errorRelay = PublishRelay<Error>()
    private let popUpRelay = PublishRelay<Void>()

    private let disposeBag = DisposeBag()
    
    init(appCoordinatorRelay: PublishRelay<AppCoordinatorSignals>,
         navigationController: UINavigationController,
         window: UIWindow,
         servicesContainer: ServicesContainer) {
        self.navigationController = navigationController
        self.window = window
        self.appCoordinatorRelay = appCoordinatorRelay
        self.servicesContainer = servicesContainer
        bind()
    }
    
    func start() {
        
        let tabBarViewController = TabBarFactory.createTabBarViewController()
        
        let messgesNavigationController = TabBarFactory.createMessegesNavigatonController()
        let messegesCoordinator = MessegesViewCoordinator(navigationController: messgesNavigationController)
        messegesCoordinator.start()
        
        let friendsNavigationController = TabBarFactory.createFriendsNavigationController()
        let friendsCoordinator = FriendsViewCoordinator(
            navigationController: friendsNavigationController,
            servicesContainer: servicesContainer)
        friendsCoordinator.start()
        
        let settingsNavigationController = TabBarFactory.createSettingsNavigationController()
        let settingsCoordinator = SettingsViewCoordinator(
            outputErrorRelay: errorRelay,
            outputRelay: settingsOutputRelay,
            navigationController: settingsNavigationController,
            servicesContainer: servicesContainer)
        settingsCoordinator.start()
        
        tabBarViewController.viewControllers = [messgesNavigationController, friendsNavigationController, settingsNavigationController]
        navigationController.setViewControllers([tabBarViewController], animated: true)
    }
    
    private func bind() {
        // Settings & PhotoPicker
        settingsOutputRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .signOut:
                    self?.appCoordinatorRelay.accept(.welcomeView)
                case .updatePhoto:
                    self?.showPhotoPicker()
                }
            })
            .disposed(by: disposeBag)
        
        photoPickerOutputRelay
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .hidePicker:
                    self?.hidePhotoPicker()
                case .imageUploaded:
                    print("@@@")
                }
            })
            .disposed(by: disposeBag)
        
        // Error Pop Up
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
    
    private func showPhotoPicker() {
        let viewModel = PhotoPickerViewModel(
            outputRelay: photoPickerOutputRelay,
            services: servicesContainer)
        let popUpViewController = PhotoPickerFactory.createPhotoPickerViewController(viewModel: viewModel)
        popUpViewController.modalPresentationStyle = .custom
        self.window.rootViewController?.present(popUpViewController, animated: false)
        self.window.makeKeyAndVisible()
    }
    
    private func hidePhotoPicker() {
        window.rootViewController?.dismiss(animated: false)
    }
    
}
