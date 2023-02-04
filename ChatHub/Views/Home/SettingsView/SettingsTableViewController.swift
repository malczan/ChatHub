//
//  SettingsTableViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    private var snapshot: DataSourceSnapshot!
    private var dataSource: DataSource!
    
    private typealias DataSource = UITableViewDiffableDataSource<String, SettingModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<String, SettingModel>

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        snapshot = DataSourceSnapshot()
        registerCell()
        configureTableViewDataSource()
        applySettingsForSnapshot(settings: [SettingModel(title: "", icon: "")])
    }
    
    private func registerCell() {
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func applySettingsForSnapshot(settings: [SettingModel]) {
        self.snapshot.appendSections(["Profile"])
        settings.forEach({ self.snapshot.appendItems([$0], toSection: "Profile") })
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, setting -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableViewCell
            return cell
        })
    }

}

struct SettingModel: Hashable {
    let title: String
    let icon: String
}
