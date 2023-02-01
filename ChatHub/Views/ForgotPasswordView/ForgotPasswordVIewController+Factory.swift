//
//  ForgotPasswordVIewController+Factory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/02/2023.
//

import UIKit

enum ForgotPasswordViewControllerFactory {
    
    static func createForgotPasswordViewController(viewModel: ForgotPasswordViewModel) -> ForgotPasswordViewController {
        
        let forgotPasswordViewController = ForgotPasswordViewController()
        forgotPasswordViewController.viewModel = viewModel
        
        return forgotPasswordViewController
    }
}
