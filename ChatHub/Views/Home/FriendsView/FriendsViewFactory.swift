//
//  FriendsViewFactory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import Foundation

enum FriendsViewFactory {
    static func createFriendsViewController(with viewModel: FriendsViewModel) -> FriendsViewController {
        let viewController = FriendsViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func createFriendsTableViewController(with viewModel: FriendsViewModel) -> FriendsTableViewController {
        let viewController = FriendsTableViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
