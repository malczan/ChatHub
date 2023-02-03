//
//  ForgotPasswordViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 30/01/2023.
//

import Foundation
import RxSwift
import RxRelay

final class ForgotPasswordViewCoordinator: Coordinator {
    
    typealias Output = ForgotPasswordViewModelOutput
    private typealias Factory = ForgotPasswordViewControllerFactory
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay: PublishRelay<Output>
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController,
         outplutRelay: PublishRelay<Output>) {
        self.navigationController = navigationController
        self.outputRelay = outplutRelay
    }
    
    func start() {
        let viewModel = ForgotPasswordViewModel(outputRelay: outputRelay)
        let forgotPasswordViewController =  Factory.createForgotPasswordViewController(viewModel: viewModel)
        navigationController.setViewControllers([forgotPasswordViewController], animated: true)
    }

}
