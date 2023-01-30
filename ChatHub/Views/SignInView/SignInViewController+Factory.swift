//
//  SignInViewController+Factoru.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 29/01/2023.
//

import UIKit

enum SignInViewControllerFactory {
    
    static func createSignInViewController(viewModel: SignInViewModel) -> SignInViewController {
        
        let signInViewController = SignInViewController()
        signInViewController.viewModel = viewModel
        
        return signInViewController
        
    }
}
