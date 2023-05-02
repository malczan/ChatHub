//
//  FriendsViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit

class FriendsViewController: UIViewController {
    
    private typealias Style = FriendsViewStyle
    
    private let searchBarTextField = UITextField()
    private let tableViewContainer = UIView()
    private var friendsTable: UITableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        installSearchBar()
        installTableViewContainer()
        installFriendsTableView()
    }
    
    private func setupUI() {
        view.backgroundColor = Style.backgroundColor
        self.title = "Friends"
        navigationController?.navigationBar.titleTextAttributes = Style.navigationTitleAtr
        
        searchBarTextField.backgroundColor = Style.purpleColor!.withAlphaComponent(Style.textFieldAlpha)
        searchBarTextField.layer.cornerRadius = Style.textFieldCornerRadius
        searchBarTextField.leftViewMode = UITextField.ViewMode.always
        searchBarTextField.leftView = Style.searchBarIcon()
        searchBarTextField.attributedPlaceholder = Style.textFieldPlaceholderAttr
        searchBarTextField.tintColor = Style.whiteColor
        searchBarTextField.textColor = Style.whiteColor
    }
    
    private func installSearchBar() {
        view.addSubview(searchBarTextField)

        searchBarTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBarTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            searchBarTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            searchBarTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func installTableViewContainer() {
        view.addSubview(tableViewContainer)
        
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableViewContainer.topAnchor.constraint(equalTo: searchBarTextField.bottomAnchor, constant: 20),
            tableViewContainer.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableViewContainer.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func installFriendsTableView() {
        friendsTable = FriendsTableViewController()
        
        self.addChild(friendsTable)
        friendsTable.view.frame = self.tableViewContainer.frame
        view.addSubview(friendsTable.view)
        
        friendsTable.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            friendsTable.view.topAnchor.constraint(equalTo: tableViewContainer.topAnchor),
            friendsTable.view.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor),
            friendsTable.view.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor),
            friendsTable.view.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor)
        ])
    }
    
    
}
