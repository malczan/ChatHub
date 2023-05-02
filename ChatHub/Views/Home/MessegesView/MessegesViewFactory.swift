//
//  MessegesViewFactory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import Foundation

enum MessegesViewFactory {
    
    static func createMessegesViewController(
        with viewModel: MessegesViewModel) -> MessegesViewController {
            let viewController = MessegesViewController()
            viewController.viewModel = viewModel
            return viewController
    }
    
    static func createMessegesListTableViewController(
        with viewModel: MessegesViewModel) -> MessegesListTableViewController {
            let viewController = MessegesListTableViewController()
            viewController.viewModel = viewModel
            return viewController
    }
}
