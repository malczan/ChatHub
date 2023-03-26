//
//  TabBarViewController.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 03/02/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var viewModel: TabBarViewModel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().backgroundColor = UIColor(named: "backgroundColor")
        UITabBar.appearance().tintColor = UIColor(named: "purple")
        
    }
}
