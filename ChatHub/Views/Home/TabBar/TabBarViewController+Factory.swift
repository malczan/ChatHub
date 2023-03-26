//
//  TabBarFactory.swift
//  ChatHub
//
//  Created by Jakub Malczyk on 04/02/2023.
//

import UIKit

enum TabBarViewControllerFactory {
    
    static func createTabBarViewController(viewModel: TabBarViewModel) -> TabBarViewController {
        
        let tabBarViewController = TabBarViewController()
        tabBarViewController.viewModel = viewModel
        return tabBarViewController
    }
    
    static func createMessegesNavigatonController() -> UINavigationController {
        let messgesNavigationController = UINavigationController()
        messgesNavigationController.tabBarItem = UITabBarItem(
            title: "Messeges",
            image: UIImage(systemName: "message"),
            tag: 0)
        return messgesNavigationController
    }
    
    static func createFriendsNavigationController() -> UINavigationController {
        let friendsNavigationController = UINavigationController()
        friendsNavigationController.tabBarItem = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.2"),
            tag: 1)
        return friendsNavigationController
        
    }
    
    static func createSettingsNavigationController() -> UINavigationController {
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 2)
        return settingsNavigationController
    }
}
