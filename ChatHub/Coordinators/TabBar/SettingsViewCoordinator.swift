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
    private let servicesContainer: ServicesContainer
    
    init(outputErrorRelay: PublishRelay<Error>,
         outputRelay: PublishRelay<Output>,
         navigationController: UINavigationController,
         servicesContainer: ServicesContainer) {
        self.outputErrorRelay = outputErrorRelay
        self.outputRelay = outputRelay
        self.navigationController = navigationController
        self.servicesContainer = servicesContainer
    }
    
    func start() {
        let viewModel = SettingsViewModel(services: servicesContainer,
                                          outputErrorRelay: outputErrorRelay,
                                          outputRelay: outputRelay)
        let settingsViewController = Factory.createSettingsViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([settingsViewController], animated: true)
    }
    
}
