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
    
    private typealias Style = MessegasViewStyle

    private typealias MessegeModel = MessagesViewModel.MessegePreviewModel
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
        applySettingsForSnapshot(messeges: viewModel.mockedMessegesList)
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
    }
    
    private func registerCell() {
        tableView.register(MessegesListTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func applySettingsForSnapshot(messeges: [MessegeModel]) {
        self.snapshot.appendSections(["All messeges"])
        messeges.forEach({ self.snapshot.appendItems([$0], toSection: "All messeges")})
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, messege -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessegesListTableViewCell
            cell.messegePreviewModel = messege
            return cell
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
}
