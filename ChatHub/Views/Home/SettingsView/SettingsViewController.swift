//
//  SettingsViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    private typealias TableFactory = SettingsTableFactory
    
    var viewModel: SettingsViewModel!
    private var headerView: SettingsHeaderView!
    private var tableViewContainer = UIView()
    private var settingsTable: UITableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backgroundColor")
        installHeaderView()
        installTableContainer()
        installSettingsTableView()
        
    }
    
    private func installHeaderView() {
        headerView = SettingsHeaderView()
        headerView.inject(viewModel: viewModel)
        
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func installTableContainer() {
        view.addSubview(tableViewContainer)
        
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            tableViewContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func installSettingsTableView() {
        settingsTable = TableFactory.createSettingsTable(viewModel: viewModel)
        
        self.addChild(settingsTable)
        settingsTable.view.frame = self.tableViewContainer.frame
        view.addSubview(settingsTable.view)
        
        settingsTable.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            settingsTable.view.topAnchor.constraint(equalTo: tableViewContainer.topAnchor),
            settingsTable.view.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor),
            settingsTable.view.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor),
            settingsTable.view.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor)
        ])
        
    }
}
