//
//  FriendsViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit

class FriendsViewController: UIViewController {

    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .white
        label.text = "Friends View"
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


}
