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
    
    private enum Section: String {
        case requests = "Friend Requests"
        case pending = "Pending"
        case friends = "Friends"
        case stranger = "Stranger"
    }
    
    var viewModel: FriendsViewModel!
    private var snapshot: DataSourceSnapshot!
    private var dataSource: DataSource!
    
    private typealias Style = FriendsViewStyle
    private typealias DataSource = UITableViewDiffableDataSource<Section, FriendModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, FriendModel>
    
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
            .friendsRequestsDriver
            .drive(onNext: {
                [weak self] in
                self?.createRequestsSnapshotSection($0)
                self?.activityIndicatorView.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .pendingRequestsDriver
            .drive(onNext: {
                [weak self] in
                self?.createPendingSnapshotSection($0)
                self?.activityIndicatorView.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel
            .friendsDriver
            .drive(onNext: {
                [weak self] in
                self?.createFriendsSnapshotSection($0)
                self?.activityIndicatorView.stopAnimating()
            }).disposed(by: disposeBag)
        
        viewModel
            .strangerDriver
            .drive(onNext: {
                [weak self] in
                self?.createStrangerSnapshotSection($0)
                self?.activityIndicatorView.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
    
    private func registerCell() {
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func createStrangerSnapshotSection(_ stranger: [FriendModel]?) {
        guard let stranger = stranger,
                  !stranger.isEmpty
        else {
            return
        }
        self.snapshot.appendSections([.stranger])
        self.snapshot.appendItems(stranger, toSection: .stranger)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createRequestsSnapshotSection(_ requests : [FriendModel]?) {
        guard let requests = requests,
                  !requests.isEmpty
        else {
            return
        }
        self.snapshot.appendSections([.requests])
        self.snapshot.appendItems(requests, toSection: .requests)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createPendingSnapshotSection(_ pending: [FriendModel]?) {
        guard let pending = pending,
                  !pending.isEmpty
        else {
            return
        }
        self.snapshot.appendSections([.pending])
        self.snapshot.appendItems(pending, toSection: .pending)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createFriendsSnapshotSection(_ friends: [FriendModel]?) {
        guard let friends = friends,
                  !friends.isEmpty
        else {
            return
        }
        self.snapshot.appendSections([.friends])
        self.snapshot.appendItems(friends, toSection: .friends)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, friend -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendsTableViewCell
            cell.friendModel = friend
            cell.viewModel = self.viewModel
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
            label.textColor = Style.purpleColor
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.text = snapshot.sectionIdentifiers[section].rawValue
            return label
    }
}
