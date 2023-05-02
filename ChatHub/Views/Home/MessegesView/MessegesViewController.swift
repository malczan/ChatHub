//
//  MessegesViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit

class MessegesViewController: UIViewController {
    
    private typealias Style = MessegesViewStyle
    private typealias Factory = MessegesViewFactory
    
    var viewModel: MessegesViewModel!
    private var messegesListTableContainer = UIView()
    private var messegesListTable: UITableViewController!

    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        installTableContainer()
        installMessgesListTableView()
    }
    
    private func setupUI() {
        self.title = "All chats"
        view.backgroundColor = Style.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = Style.navigationControllerAttr 
    }
    
    private func installTableContainer() {
        view.addSubview(messegesListTableContainer)
        
        messegesListTableContainer.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            messegesListTableContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            messegesListTableContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messegesListTableContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messegesListTableContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func installMessgesListTableView() {
        messegesListTable = Factory.createMessegesListTableViewController(with: viewModel)
        
        self.addChild(messegesListTable)
        messegesListTable.view.frame = self.messegesListTableContainer.frame
        view.addSubview(messegesListTable.view)
        
        messegesListTable.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messegesListTable.view.topAnchor.constraint(
                equalTo: messegesListTableContainer.topAnchor),
            messegesListTable.view.leadingAnchor.constraint(
                equalTo: messegesListTableContainer.leadingAnchor),
            messegesListTable.view.trailingAnchor.constraint(equalTo: messegesListTableContainer.trailingAnchor),
            messegesListTable.view.bottomAnchor.constraint(equalTo: messegesListTableContainer.bottomAnchor)
        ])
        
    }
    
    
}
