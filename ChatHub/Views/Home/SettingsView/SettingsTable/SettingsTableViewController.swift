//
//  SettingsTableViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsTableViewController: UITableViewController {
    
    var viewModel: SettingsViewModel!
    
    private var snapshot: DataSourceSnapshot!
    private var dataSource: DataSource!
    
    private typealias DataSource = UITableViewDiffableDataSource<String, SettingModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<String, SettingModel>
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        tableView.isScrollEnabled = false
        snapshot = DataSourceSnapshot()
        registerCell()
        configureTableViewDataSource()
        applySettingsForSnapshot(settings: viewModel.settings())
        bind()
    }
    
    private func bind() {
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] in
                guard let cell = self?.dataSource.itemIdentifier(for: $0) else { return }
                self?.viewModel.selected(cell: cell)
            }).disposed(by: disposeBag)
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
            cell.model = setting
            return cell
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
}
