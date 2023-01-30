//
//  WelcomeViewController+Factory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import Foundation

enum WelcomeViewControllerFactory {
    
    static func createWelcomeViewController(viewModel: WelcomeViewModel) -> WelcomeViewController {
        
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.viewModel = viewModel
        
        return welcomeViewController
    }
}
