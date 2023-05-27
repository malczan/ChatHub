//
//  MessegesViewFactory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import Foundation

enum MessagesViewFactory {
    
    static func createMessegesViewController(
        with viewModel: MessagesViewModel) -> MessagesViewController {
            let viewController = MessagesViewController()
            viewController.viewModel = viewModel
            return viewController
    }
    
    static func createMessegesListTableViewController(
        with viewModel: MessagesViewModel) -> MessegesListTableViewController {
            let viewController = MessegesListTableViewController()
            viewController.inject(viewModel: viewModel)
            return viewController
    }
}
