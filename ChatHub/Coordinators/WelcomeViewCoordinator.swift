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
    private let welcomeRelay: PublishRelay<Output>
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController,
         welcomeRelay: PublishRelay<Output>) {
        self.navigationController = navigationController
        self.welcomeRelay = welcomeRelay
    }
    
    func start() {
        let viewModel = WelcomeViewModel(outputScreenSelected: welcomeRelay)
        let welcomeViewController =  Factory.createWelcomeViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([welcomeViewController], animated: false)
    }

}
