//
//  MessegesViewCoordinator.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit
import RxRelay
import RxSwift

final class MessegesViewCoordinator: Coordinator {
    
    private typealias Factory = MessagesViewFactory
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let outputRelay: PublishRelay<Void>
    private let disposeBag = DisposeBag()

    init(navigationController: UINavigationController,
         outputRelay: PublishRelay<Void>) {
        self.navigationController = navigationController
        self.outputRelay = outputRelay
    }
    
    func start() {
        let viewModel = MessagesViewModel(outputRelay: outputRelay)
        let messegesViewController = Factory.createMessegesViewController(with: viewModel)
        
        navigationController.setViewControllers([messegesViewController], animated: true)
    }
}
