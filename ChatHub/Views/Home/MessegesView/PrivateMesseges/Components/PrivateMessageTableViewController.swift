//
//  PrivateMessageTableViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 25/05/2023.
//

import UIKit
import RxCocoa
import RxSwift

class PrivateMessageTableViewController: UITableViewController {
    
    typealias Style = MessagesViewStyle
    typealias MessageModel = PrivateMesssageViewModel.MessageModel
    
    private var snapshot: DataSourceSnapshot!
    private var dataSource: DataSource!
    private var viewModel: PrivateMesssageViewModel!
    private let disposeBag = DisposeBag()
    
    private typealias DataSource = UITableViewDiffableDataSource<Int, MessageModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, MessageModel>

    override func viewDidLoad() {
        super.viewDidLoad()
        snapshot = DataSourceSnapshot()
        setupStyle()
        registerCell()
        configureTableViewDataSource()
    }
    
    func inject(viewModel: PrivateMesssageViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    private func bind() {
        viewModel
            .messageDriver
            .drive(onNext: {
            [weak self] messages in
            self?.applySnapshot(messages: messages)
        })
        .disposed(by: disposeBag)
        
        viewModel
            .newMessageDriver
            .drive(onNext: {
                [weak self] message in
                self?.updateSnaphot(with: message)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupStyle() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = Style.backgroundColor
    }
    
    private func registerCell() {
        tableView.register(PrivateSentMessageCell.self, forCellReuseIdentifier: "SentMessageCell")
        tableView.register(PrivateReceivedMessageCell.self, forCellReuseIdentifier: "ReceivedMessageCell")
    }
    
    private func applySnapshot(messages: [MessageModel]?) {
        guard let messages = messages else {
            return
        }
        self.snapshot.appendSections([0])
        messages.forEach({ self.snapshot.appendItems([$0], toSection: 0) })
        dataSource.apply(snapshot, animatingDifferences: false)
        guard let lastMessage = messages.last else {
            return
        }
        let indexPath = dataSource.indexPath(for: lastMessage)
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath!, at: .bottom, animated: false)
    }
    
    private func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, messageModel -> UITableViewCell? in
            switch messageModel.fromCurrentUser {
            case true:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SentMessageCell", for: indexPath) as! PrivateSentMessageCell
                cell.model = messageModel
                return cell
            case false:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedMessageCell", for: indexPath) as! PrivateReceivedMessageCell
                cell.model = messageModel
                return cell
            }
            
        })
    }
    
    private func updateSnaphot(with messages: [MessageModel]) {
        guard let lastMessage = messages.last,
              snapshot.numberOfSections > 0 else {
            return
        }
        
        snapshot.appendItems(messages, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
        let indexPath = dataSource.indexPath(for: lastMessage)
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath!, at: .bottom, animated: true)
    }
}
