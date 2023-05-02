//
//  FriendsTableViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 02/05/2023.
//

import UIKit
import RxCocoa
import RxSwift

class FriendsTableViewController: UITableViewController {
    
    let viewModel = FriendsViewModel()
    
    private var snapshot: DataSourceSnapshot!
    private var dataSource: DataSource!
    
    private typealias FriendModel = FriendsViewModel.FriendModel
    private typealias DataSource = UITableViewDiffableDataSource<String, FriendModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<String, FriendModel>
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        snapshot = DataSourceSnapshot()
        registerCell()
        configureTableViewDataSource()
        createSnapshotSection(with: viewModel.mockedFriendsList)
        bind()
    }
    
    private func bind() {
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { _ in
            }).disposed(by: disposeBag)
    }
    
    private func registerCell() {
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func createSnapshotSection(with users: [FriendModel]) {
        self.snapshot.appendSections(["Friends"])
        self.snapshot.appendItems(users, toSection: "Friends")
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    
    private func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, setting -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendsTableViewCell
//            cell.model = setting
            return cell
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section"
    }
}
