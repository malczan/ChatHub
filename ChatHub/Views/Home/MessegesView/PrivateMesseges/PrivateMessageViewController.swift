//
//  PrivateMessegeViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 20/05/2023.
//

import UIKit

class PrivateMessageViewController: UIViewController {
    
    typealias Style = MessegasViewStyle
    
    var viewModel: PrivateMesssageViewModel!
    
    let addButton = UIBarButtonItem(title: "Add")


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        installHeader()
    }
    
    
    private func setupUI() {
        view.backgroundColor = Style.backgroundColor
    }
    
    private func installHeader() {
        let headerView = PrivateMessageHeaderView()
        headerView.inject(viewModel: viewModel)
        
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
