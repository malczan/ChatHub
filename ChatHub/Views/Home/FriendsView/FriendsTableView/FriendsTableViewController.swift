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
    
    var viewModel: FriendsViewModel!
    private var snapshot: DataSourceSnapshot!
    private var dataSource: DataSource!
    
    private typealias DataSource = UITableViewDiffableDataSource<String, FriendModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<String, FriendModel>
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        installIndicatorView()
        snapshot = DataSourceSnapshot()
        registerCell()
        configureTableViewDataSource()
        bind()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        tableView.rowHeight = 50
        activityIndicatorView.startAnimating()
    }
    
    private func bind() {
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        
        viewModel
            .friendsDriver
            .drive(onNext: {
                [weak self] in
                self?.createSnapshotSection(with: $0)
                self?.tableView.isHidden = false
                self?.activityIndicatorView.stopAnimating()
            }).disposed(by: disposeBag)
    }
    
    private func registerCell() {
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func createSnapshotSection(with users: [FriendModel]?) {
        guard let users = users else {
            return
        }

        self.snapshot.appendSections(["Friends"])
        self.snapshot.appendItems(users, toSection: "Friends")
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    
    private func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, friend -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendsTableViewCell
            cell.friendModel = friend
            return cell
        })
    }
    
    private func installIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section"
    }
}
