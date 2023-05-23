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
}
