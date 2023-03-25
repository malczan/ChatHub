//
//  SettingsViewController+Factory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import Foundation

enum SettingsViewControllerFactory {
    
    static func createSettingsViewController(viewModel: SettingsViewModel) -> SettingsViewController {
        
        let settingsViewController = SettingsViewController()
        settingsViewController.viewModel = viewModel
        
        return settingsViewController
    }
}
