//
//  MessegesListTableViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 01/05/2023.
//

import UIKit
import RxCocoa
import RxSwift

class MessegesListTableViewController: UITableViewController {
    
    var viewModel: MessagesViewModel!
    
    private var snapshot: DataSourceSnapshot!
    private var dataSource: DataSource!
    
    private typealias Style = MessagesViewStyle

    private typealias MessegeModel = MessagesViewModel.MessegePreview
    private typealias DataSource = UITableViewDiffableDataSource<String, MessegeModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<String, MessegeModel>
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 62
        setupUI()
        snapshot = DataSourceSnapshot()
        registerCell()
        configureTableViewDataSource()
    }
    
    func inject(viewModel: MessagesViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    private func setupUI() {
        view.backgroundColor = Style.backgroundColor
    }
    
    private func bind() {
        tableView
            .rx
            .itemSelected
            .subscribe(onNext: {
                [weak self] _ in
                self?.viewModel.chatSelected()
            }).disposed(by: disposeBag)
        
        viewModel
            .recentMessagesDriver
            .drive(onNext: {
                [weak self] in
                self?.applySettingsForSnapshot(messeges: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func registerCell() {
        tableView.register(MessegesListTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func applySettingsForSnapshot(messeges: [MessegeModel]?) {
        guard let messeges = messeges else {
            return
        }

        self.snapshot.appendSections(["All messeges"])
        messeges.forEach({ self.snapshot.appendItems([$0], toSection: "All messeges")})
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, messege -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessegesListTableViewCell
            cell.inject(viewModel: self.viewModel)
            cell.messegePreviewModel = messege
            return cell
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
}
