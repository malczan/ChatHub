//
//  SettingsViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit
import Swinject
import RxSwift
import RxRelay

final class SettingsViewCoordinator: Coordinator {
    
    typealias Output = SettingsViewModelOutput
    private typealias Factory = SettingsViewControllerFactory
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    private let outputErrorRelay: PublishRelay<Error>
    private let outputRelay: PublishRelay<Output>
    private let resolver: Resolver
    
    init(outputErrorRelay: PublishRelay<Error>,
         outputRelay: PublishRelay<Output>,
         navigationController: UINavigationController,
         resolver: Resolver) {
        self.outputErrorRelay = outputErrorRelay
        self.outputRelay = outputRelay
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() {
        let authService = resolver.resolve(AuthorizationService.self)!
        let userService = resolver.resolve(UserService.self)!
        let viewModel = SettingsViewModel(authService: authService,
                                          userService: userService,
                                          outputErrorRelay: outputErrorRelay,
                                          outputRelay: outputRelay)
        let settingsViewController = Factory.createSettingsViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([settingsViewController], animated: true)
    }
    
}
