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
        installFooter()
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
    
    private func installFooter() {
        let footerView = PrivateMessageFooterView()
        footerView.inject(viewModel: viewModel)
        
        view.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
