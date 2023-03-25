//
//  SignUpViewControllerFactory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 30/01/2023.
//

import Foundation

enum SignUpViewControllerFactory {
    
    static func createSignUnViewController(viewModel: SignUpViewModel) -> SignUpViewController {
        
        let signUnViewController = SignUpViewController()
        signUnViewController.viewModel = viewModel
        
        return signUnViewController
        
    }
}
