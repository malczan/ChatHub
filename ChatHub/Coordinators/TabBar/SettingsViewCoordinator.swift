//
//  SettingsViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit
import RxSwift
import RxRelay

final class SettingsViewCoordinator: Coordinator {
    
    typealias Output = SettingsViewModelOutput
    private typealias Factory = SettingsViewControllerFactory
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController

    private let outputErrorRelay: PublishRelay<Error>
    private let outputRelay: PublishRelay<Output>
    
    init(outputErrorRelay: PublishRelay<Error>,
         outputRelay: PublishRelay<Output>,
         navigationController: UINavigationController) {
        self.outputErrorRelay = outputErrorRelay
        self.outputRelay = outputRelay
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SettingsViewModel(outputErrorRelay: outputErrorRelay,
                                          outputRelay: outputRelay)
        let settingsViewController = Factory.createSettingsViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([settingsViewController], animated: true)
    }
    
}
