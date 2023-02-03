//
//  PopUpViewController+Factory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/02/2023.
//

import Foundation

enum PopUpViewControllerFactory {
    
    static func createPopUpViewController(viewModel: PopUpViewModel) -> PopUpViewController {
        
        let popUpViewController = PopUpViewController()
        popUpViewController.viewModel = viewModel
        
        return popUpViewController
        
    }
}
