//
//  PrivateMessageViewFactory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 23/05/2023.
//

import Foundation

enum PrivateMessageViewFactory {
    
    static func createPrivateMessageViewController(
        viewModel: PrivateMesssageViewModel)
        -> PrivateMessageViewController {
        
            let viewController = PrivateMessageViewController()
            viewController.viewModel = viewModel
            
            return viewController
    }
    
    static func createHeader(viewModel: PrivateMesssageViewModel)
        -> PrivateMessageHeaderView {
            
            let headerView = PrivateMessageHeaderView()
            headerView.inject(viewModel: viewModel)
            
            return headerView
    }
    
    static func createTableViewController(viewModel: PrivateMesssageViewModel)
        -> PrivateMessageTableViewController {
            
            let tableViewController = PrivateMessageTableViewController()
            tableViewController.inject(viewModel: viewModel)
            
            return tableViewController
    }
    
    static func createFooter(viewModel: PrivateMesssageViewModel)
        -> PrivateMessageFooterView {
            
            let footerView = PrivateMessageFooterView()
            footerView.inject(viewModel: viewModel)
            
            return footerView
    }
}
