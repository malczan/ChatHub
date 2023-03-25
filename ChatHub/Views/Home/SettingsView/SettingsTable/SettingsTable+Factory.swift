//
//  SettingsTable+Factory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import Foundation

enum SettingsTableFactory {
    
    static func createSettingsTable(viewModel: SettingsViewModel) -> SettingsTableViewController {
        let settingsTableViewController = SettingsTableViewController()
        settingsTableViewController.viewModel = viewModel
        return settingsTableViewController
    }
}
