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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        installSearchBar()
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
}
